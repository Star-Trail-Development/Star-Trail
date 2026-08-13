# Star Trail

Star Trail 服务器专用整合包仓库，使用 [packwiz](https://github.com/packwiz/packwiz) 管理必要文件，通过分支结构与 GitHub Actions 灵活构筑仓库。

## 分支结构

| 分支 | 用途 |
|------|------|
| `release` | 发布分支，`.index/` 展平 + 元数据修复 + `packwiz refresh` 后再次提交至此分支 |
| `download` | 下载分支，通过 Prism Launcher 管理模组和材质包等，变更后同步至release分支 |
| `develop` | 开发分支，存放 `config/`、`kubejs/` 等非需下载资源的配置文件，变更后合并至release分支 |

## 目录结构

```
.
├── .github/workflows/		# 工作流目录
│   └── release-update.yml
├── mods/                   # 模组元数据 (.pw.toml)
├── resourcepacks/          # 材质包元数据 (.pw.toml)
├── shaderpacks/            # 光影元数据 (.pw.toml)
├── config/                 # 游戏配置
├── defaultconfigs/         # 默认存档配置
├── CustomSkinLoader/       # 皮肤补丁模组配置
├── kubejs/                 # KubeJS 魔改脚本
├── pack.toml               # 整合包定义
├── index.toml              # packwiz 索引（自动生成）
├── fix-metadata.sh         # 元数据修复脚本
├── packwiz                 # packwiz 发行版
└── .packwizignore          # packwiz 忽略规则
```

## 客户端自动更新

通过在启动器内配置预启动命令，[packwiz-installer](https://github.com/packwiz/packwiz-installer) 启动后从本仓库 `release` 分支拉取文件，然后检测更新并下载。

鉴于 `CurseForge` 和 `Modrinth` 不能流畅访问，故配置元数据时使用了 [MCIM](https://www.mcimirror.top/) 代理网站和私人服务器。
