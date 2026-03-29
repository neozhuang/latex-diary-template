# LaTeX Coil Diary Template

[仓库地址](https://github.com/neozhuang/latex-diary-template)

预览效果：

---

## How to Compile

| 文件        | 说明                    |
| ----------- | -----------------------|
| `diary.tex` | 主文件                  |
| `diary.cls` | 库文件                  |
| `Makefile`  | linux编译文件           |
| `clean.bat` | windows一键清理辅助文件  |
| `build.bat` | windows一键编译源文件   |


**编译方法：** `xelatex *.tex` 两次

Windows编译便捷批处理文件：

- `clean.bat` - 清理当前目录及子目录所有辅助文件；
- `build.bat` - 重新编译目录中所有`.tex`并清理辅助文件。

Linux/Mac等类Unix快速编译：

- `make`            - 编译目录中所有`.tex`文件，不清理中间文件；
- `make clean`      - 清理所有辅助文件；
- `make rebuild`    - 先清理辅助文件，再编译所有.tex文件并清理辅助文件。

latexmk:

- `latexmk -xelatex` - 默认逐个编译当前目录所有.tex文件
- `latexmk -c`       - 清理所有.tex文件生成的中间文件，不包括最终pdf
- `latexmk -C`       - 清理所有.tex文件生成的中间文件，包括最终pdf

---

## Usage

### 标题页起止日期

```latex
% 指定起止日期
\BeginAt[2026][01][01]                  % 指定起始年月日
\EndAt[\getYear][\getMonth][\getDay]    % 最后一次编译当天的日期 可不修改
```

开始日期可手动填写。[]表示采用可选默认参数，可依次省略后面的不写。
比如 `\BeginAt[2026]` 默认显示2026年01月01日，默认值在 cls 文件中修改。

终止日期同上。

### 字体设置

```latex
% 标题页专用字体，如不设置沿用正文字体
%\TitleCJKFont{Noto Sans CJK SC}         % 标题页中文字体
%\TitleFont{Noto Sans}                   % 标题页英文字体

% 正文字体，如不设置则使用系统默认字体
%\setCJKmainfont{Noto Serif CJK SC}      % 正文中文字体
%\setmainfont{Noto Serif}                % 正文英文字体
```

可将上述几种字体分别设置为本地已安装的字体。

> [!NOTE]
> 设置正文字体后编译会出现如下警告：
>
> [LaTeX Warning] Line 1: Package xeCJK: Redefining CJKfamily `\CJKrmdefault' (xeCJK)	(FandolSong-Regular(0)).
>
> 这个是由于我们自己设置了正文字体与ctex提供的默认版本的重复导致的，可以忽略此warning。

查看系统已安装字体：

- Windows: `dir C:\Windows\Fonts`
- Linux: `fc-list : family | sort | uniq`

如何搭配选择好看的字体：[ChatGPT](https://chatgpt.com/)

### 位置、日期、天气

```latex
\Address[中国][北京]
\Date{2026}{1}{1}[\faSun]%
```

`\Address[][]` 两个参数设置位置信息，默认值为江苏 苏州，可在 cls 中修改。

```latex
\Address            % 显示江苏苏州
\Address[][家]      % 第一个参数设为空，只显示家
```

`Date{}{}{}[]` 前三个必选参数分别指定年月日，第四个可选参数为天气或心情等图标。
图标使用fontawesome7图标库，可选样式（solid或regular），默认是 solid。
图标命令可终端输入 `texdoc fontawesome7` 查看文档，或查看fontawesome官网。
省略后跟随前一天填写的图标。

`\Date{}{}{}[]` 后面必须要有`%`，且该命令与日记内容之间不能有空行，否则会引入不必要的空格和空行。

### 其他

`\Theme{}` 为每一天设定一个主题，格式为居中。

星期几根据日期值通过 `datetime2` 宏包自动计算。

> [!CAUTION]
> `\Date` 强制换页，实际每页只使用其中一栏（左右对称装饰）。
> 用户若想在双栏间自然流动内容，可能会发现排版错乱。
> 因此此模板适用于单篇日记独立成页。

---

## TO DO

1. **背景性能** 每页都绘制大量 TikZ 图形（线圈、网格等），编译速度较慢。可考虑预定义样式或使用 pgf 缓存。
2. **线圈位置计算** `\SpiralPosition` 中的 `\Valor*(\textheight+2.5cm)/(\SpiralNumber-1)` 混合了绝对长度与相对长度，可能导致不同页面（如标题页）线圈位置偏移。可改用 `\pgfmathsetlength` 动态计算。
3. **多语言兼容** 封面日期以及正文页的日期年月，还有星期几的映射问题，需要查看`babel` `datetime2`等宏包使用说明，考虑做一个语言开关还是直接再写别的语言版本的cls。

---

## References

该模板基于以下模板修改：

- https://github.com/cs-qyzhang/LaTeX-Diary

- https://github.com/Come-on-ZMZ/LaTeX-Diary
