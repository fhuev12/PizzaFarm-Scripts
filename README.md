# PizzaFarm-Scripts

Roblox「披萨店」自动工作脚本 —— LZSS 压缩 + 随机密钥异或 + Base64 分片保护构建。

## 调用

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/fhuev12/PizzaFarm-Scripts/main/PizzaFarm_AutoWork_v1.lua"))()
```

> 必须使用支持 `getrawmetatable` / `getupvalues` / `setupvalue` / `getreg` 的高权限执行器（Synapse X、KRNL 等）。低权限执行器会直接提示 "Incompatible exploit" 后退出。

## 构建参数

| 项目 | 值 |
| --- | --- |
| 源文件 | `披萨店自动工作.lua`（35,382 B / 796 行） |
| 源 SHA-256 | `559240674864b542973b3b227dabf9f901deb4b32c478def530211f5e0bacd4f` |
| 压缩算法 | LZSS（window 32768 / maxlen 255 / min match 3） |
| 加密 | 4 B 小端压缩长度头 + 28 字符随机密钥循环 XOR |
| 载荷 | Base64 14,676 字符 → 3 片，每片 4,892 B |
| 加载器 | `PizzaFarm_AutoWork_v1.lua`（3,383 B，blob `fb77720f…`） |
| 密文体积 | 11,002 B（压缩率 31.1%） |

## 目录

```
PizzaFarm_AutoWork_v1.lua              加载器（解码+解压+执行）
parts/PizzaFarm_AutoWork_v1.p1.txt     分片 1 / 4,892 B / blob 0a91771b…
parts/PizzaFarm_AutoWork_v1.p2.txt     分片 2 / 4,892 B / blob ccdc688f…
parts/PizzaFarm_AutoWork_v1.p3.txt     分片 3 / 4,892 B / blob bdd60cb3…
```

## 验证

加载器逐片 `game:HttpGet` 拉取 → 拼接 → 去空白 → Base64 解码 → `bit32.bxor` 解密 → LZSS 解压 → 校验长度头 → `loadstring` 执行。

线上端到端复验：从 `raw.githubusercontent.com` 下载加载器 + 全部 3 片（均 HTTP 200，字节数 3,383 / 4,892 × 3 一致），用本地桩脚本解码后 SHA-256 = `559240674864b542973b3b227dabf9f901deb4b32c478def530211f5e0bacd4f`，与源文件逐字节相同。

## 脚本行为摘要

- 配置：`settings={refill_at=50, refill_end=97, stay_in_kitchen=true}`；`readfile("PizzaFarm.txt")` + `HttpService:JSONDecode` 读取本地配置并校验补全字段。
- 五个功能开关：`doCashier`（收银）、`doBoxer`（装箱）、`doCook`（做餐）、`doSupplier`（补货）、`doDelivery`（送餐）。
- 25 处 `FireServer`：`OrderComplete`、`SquishDough`、`AddIngredientToPizza(TomatoSauce/Cheese/配料)`、`oven.Door.ClickDetector.Detector`、`CloseBox`/`OpenBox`、`UpdateProperty(对象,"CFrame"/"Anchored",值)`、垃圾桶传送等。
- 无 `HttpGet`、无 `loadstring`、无 webhook，脚本本身不含任何回传或远程加载代码。

## 警告

这是第三方辅助脚本。高频远程调用与自动化操作违反 Roblox 服务条款，存在封号风险。仅自行承担使用后果。
