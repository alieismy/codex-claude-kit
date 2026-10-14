#!/usr/bin/env python3
"""Validate the maintained Codex TOML examples against a pinned JSON Schema."""

from __future__ import annotations

import argparse
import copy
import hashlib
import json
import sys
from pathlib import Path
from typing import Any

try:
    import tomllib
except ModuleNotFoundError:  # Python 3.9-3.10
    try:
        import tomli as tomllib
    except ModuleNotFoundError as exc:  # pragma: no cover - dependency failure
        raise SystemExit(
            "tomli is required on Python 3.9-3.10; install requirements-validation.txt"
        ) from exc

try:
    from jsonschema import validators
except ModuleNotFoundError as exc:  # pragma: no cover - dependency failure
    raise SystemExit(
        "jsonschema is required; install requirements-validation.txt"
    ) from exc


ROOT = Path(__file__).resolve().parent.parent
DEFAULT_SCHEMA = ROOT / "schemas" / "codex-config.schema.json"
DEFAULT_METADATA = ROOT / "schemas" / "codex-config.schema.meta.json"
CONFIGS = (
    Path("codex/examples/config.example.toml"),
    Path("codex/examples/config.full-access.example.toml"),
    Path("zh-CN/codex/examples/config.example.toml"),
    Path("zh-CN/codex/examples/config.full-access.example.toml"),
    Path("codex/examples/config.project.example.toml"),
    Path("zh-CN/codex/examples/config.project.example.toml"),
)
STANDARD_CONFIGS = (
    Path("codex/examples/config.example.toml"),
    Path("zh-CN/codex/examples/config.example.toml"),
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--schema",
        type=Path,
        default=DEFAULT_SCHEMA,
        help="JSON Schema to use (defaults to the tracked offline snapshot)",
    )
    return parser.parse_args()


def display_path(path: Path) -> str:
    try:
        return path.resolve().relative_to(ROOT).as_posix()
    except ValueError:
        return str(path.resolve())


def json_path(parts: Any) -> str:
    rendered = "$"
    for part in parts:
        if isinstance(part, int):
            rendered += f"[{part}]"
        else:
            rendered += f".{part}"
    return rendered


def load_toml(path: Path, errors: list[str]) -> dict[str, Any] | None:
    try:
        with path.open("rb") as stream:
            return tomllib.load(stream)
    except (OSError, tomllib.TOMLDecodeError) as exc:
        errors.append(f"{display_path(path)}: TOML parse failed: {exc}")
        return None


def validate_snapshot_metadata(schema_path: Path, errors: list[str]) -> None:
    try:
        metadata = json.loads(DEFAULT_METADATA.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        errors.append(f"{display_path(DEFAULT_METADATA)}: metadata parse failed: {exc}")
        return

    required_text = (
        "schema_file",
        "source_version",
        "tagged_source_url",
        "live_source_url",
        "retrieved_date",
        "sha256",
        "license",
        "license_source_url",
        "license_file",
        "notice_file",
    )
    for key in required_text:
        if not isinstance(metadata.get(key), str) or not metadata[key].strip():
            errors.append(f"{display_path(DEFAULT_METADATA)}: missing text field {key}")

    if metadata.get("schema_file") != schema_path.name:
        errors.append(
            f"{display_path(DEFAULT_METADATA)}: schema_file must be {schema_path.name!r}"
        )

    schema_bytes = schema_path.read_bytes()
    if metadata.get("byte_length") != len(schema_bytes):
        errors.append(
            f"{display_path(schema_path)}: schema byte length differs from metadata"
        )
    digest = hashlib.sha256(schema_bytes).hexdigest().upper()
    if str(metadata.get("sha256", "")).upper() != digest:
        errors.append(f"{display_path(schema_path)}: schema SHA-256 differs from metadata")
    if metadata.get("license") != "Apache-2.0":
        errors.append(
            f"{display_path(DEFAULT_METADATA)}: license must identify Apache-2.0"
        )

    for key in ("license_file", "notice_file"):
        value = metadata.get(key)
        if isinstance(value, str) and value and not (DEFAULT_METADATA.parent / value).is_file():
            errors.append(
                f"{display_path(DEFAULT_METADATA)}: referenced {key} does not exist: {value}"
            )


def comparable(document: dict[str, Any]) -> dict[str, Any]:
    result = copy.deepcopy(document)
    result.pop("developer_instructions", None)
    return result


def main() -> int:
    args = parse_args()
    schema_path = args.schema.resolve()
    errors: list[str] = []

    try:
        schema = json.loads(schema_path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        print(f"Codex config validation failed:\n - {schema_path}: {exc}", file=sys.stderr)
        return 1

    if schema_path == DEFAULT_SCHEMA.resolve():
        validate_snapshot_metadata(schema_path, errors)

    try:
        validator_class = validators.validator_for(schema)
        validator_class.check_schema(schema)
        validator = validator_class(schema)
    except Exception as exc:  # jsonschema exposes validator-specific exceptions
        print(f"Codex config validation failed:\n - invalid schema: {exc}", file=sys.stderr)
        return 1

    documents: dict[Path, dict[str, Any]] = {}
    for relative_path in CONFIGS:
        path = ROOT / relative_path
        document = load_toml(path, errors)
        if document is None:
            continue
        documents[relative_path] = document
        for validation_error in sorted(
            validator.iter_errors(document),
            key=lambda item: tuple(str(part) for part in item.absolute_path),
        ):
            errors.append(
                f"{relative_path.as_posix()} {json_path(validation_error.absolute_path)}: "
                f"{validation_error.message}"
            )

    mirror_pairs = (
        (CONFIGS[0], CONFIGS[2], "standard"),
        (CONFIGS[1], CONFIGS[3], "full-access"),
        (CONFIGS[4], CONFIGS[5], "project"),
    )
    for english_path, chinese_path, label in mirror_pairs:
        if english_path not in documents or chinese_path not in documents:
            continue
        if comparable(documents[english_path]) != comparable(documents[chinese_path]):
            errors.append(
                f"English/Chinese {label} Codex examples differ semantically "
                "outside top-level developer_instructions"
            )

    expected_contract = (
        (("model",), "gpt-6-astra"),
        (("model_reasoning_effort",), "xhigh"),
        (("plan_mode_reasoning_effort",), "high"),
        (("agents", "enabled"), True),
        (("agents", "max_concurrent_threads_per_session"), 2),
        (("agents", "default_subagent_model"), "gpt-6.1-sol"),
        (("agents", "default_subagent_reasoning_effort"), "high"),
        (("web_search",), "live"),
        (("shell_environment_policy", "inherit"), "all"),
        (("shell_environment_policy", "ignore_default_excludes"), False),
        (("features", "memories"), True),
        (("mcp_servers", "deepwiki", "url"), "https://mcp.deepwiki.com/mcp"),
        (("mcp_servers", "deepwiki", "enabled"), False),
        (("mcp_servers", "deepwiki", "enabled_tools"), ["read_wiki_structure", "read_wiki_contents", "ask_wiki_question"]),
        (("mcp_servers", "tavily", "url"), "https://mcp.tavily.com/mcp"),
        (("mcp_servers", "tavily", "bearer_token_env_var"), "TAVILY_API_KEY"),
        (("mcp_servers", "tavily", "enabled"), False),
        (("mcp_servers", "tavily", "tool_timeout_sec"), 120),
        (("mcp_servers", "tavily", "enabled_tools"), ["tavily_search", "tavily_extract"]),
    )
    for relative_path in STANDARD_CONFIGS:
        document = documents.get(relative_path)
        if document is None:
            continue
        for key_path, expected in expected_contract:
            current: Any = document
            try:
                for key in key_path:
                    current = current[key]
            except (KeyError, TypeError):
                current = None
            if current != expected or type(current) is not type(expected):
                dotted_key = ".".join(key_path)
                errors.append(
                    f"{relative_path.as_posix()}: required contract {dotted_key} "
                    f"must be {expected!r}, found {current!r}"
                )

    expected_project = {
        "approval_policy": "on-request",
        "sandbox_mode": "workspace-write",
        "sandbox_workspace_write": {"network_access": False},
    }
    for relative_path in CONFIGS[4:]:
        document = documents.get(relative_path)
        if document is not None and document != expected_project:
            errors.append(
                f"{relative_path.as_posix()}: project Codex example must contain only "
                "the reviewed approval and workspace sandbox overrides"
            )

    if errors:
        print("Codex config validation failed:", file=sys.stderr)
        for error in errors:
            print(f" - {error}", file=sys.stderr)
        return 1

    print(
        f"Codex config validation passed ({len(CONFIGS)} files; "
        f"schema: {display_path(schema_path)})."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
