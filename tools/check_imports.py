#!/usr/bin/env python3
"""依赖方向守护（六边形边界，CI 第〇关）。

规则来源：docs/SAS-软件架构说明书.md §6 / docs/02-软件架构与工作流程.md §2.3 依赖规则表。
违规即退出码 1，评审第〇条：依赖方向违规的 PR 不看内容直接打回。
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PKG = "packages"
APP = "apps"

# 禁止出现的 import 前缀 → 适用包（lib/ 目录）
FORBID: dict[str, list[str]] = {
    "contracts": ["package:flutter", "package:dio", "package:http", "package:drift"],
    "core_agent": ["package:flutter", "package:dio", "package:http", "package:drift"],
    "learning_engine": ["package:flutter", "package:dio", "package:http", "package:drift"],
    "provider_kit": ["package:flutter", "package:drift"],
    "data_layer": ["package:flutter", "package:dio", "package:http"],
    # ui_kit 纯展示：禁止 import 业务包
    "ui_kit": [
        "package:core_agent",
        "package:learning_engine",
        "package:provider_kit",
        "package:data_layer",
    ],
}

# data_layer 允许 drift；provider_kit 允许 http/dio（上面 forbid 表已按此收紧）
IMPORT_RE = re.compile(r"^\s*(?:import|export)\s+['\"]([^'\"]+)['\"]", re.M)


def check() -> int:
    violations: list[str] = []
    for pkg, forbidden in FORBID.items():
        pkg_dir = ROOT / PKG / pkg / "lib"
        if not pkg_dir.exists():
            continue
        for f in pkg_dir.rglob("*.dart"):
            for m in IMPORT_RE.finditer(f.read_text(encoding="utf-8")):
                uri = m.group(1)
                if uri.startswith("dart:"):
                    continue
                for bad in forbidden:
                    if uri.startswith(bad):
                        rel = f.relative_to(ROOT)
                        violations.append(f"{rel}: import '{uri}' 违反依赖方向（禁止 {bad}）")
    if violations:
        print(f"✗ 依赖方向违规 {len(violations)} 处：")
        for v in violations:
            print("  -", v)
        return 1
    print("✓ 依赖方向检查通过（六边形边界完好）")
    return 0


if __name__ == "__main__":
    sys.exit(check())
