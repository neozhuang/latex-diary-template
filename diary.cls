%  -----------------------------------------------------------------------
% Author       : neozhuang
% Email        : zhuangzhuangzhang97@gmail.com
% CreateTime   : 2026-03-28 12:11:12 +0800
% LastEditTime : 2026-03-28 12:45:28 +0800
% Description  :  LaTeX Coil Diary Template
%  -----------------------------------------------------------------------
%

\def\Version{v1.3}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{diary}[2026/03/28 \Version LaTeX Coil Diary Template --neozhuang]

% 固定双栏，A4纸，横向
\LoadClass[a4paper,twocolumn]{article}
\RequirePackage[UTF8]{ctex}
\RequirePackage[landscape]{geometry}
\geometry{left=2.0cm, right=2.0cm, top=4.5cm, bottom=2.5cm}

% 绘图功能
\RequirePackage{tikz}
% 加载 TikZ 的几个功能库，提供阴影效果、坐标计算和相对定位语法
\usetikzlibrary{shadows,calc,positioning}
\RequirePackage{tikzpagenodes}
\RequirePackage{xcolor}

% 处理日期和时间的宏包，提供了丰富的日期格式化和计算功能
\RequirePackage[calc]{datetime2}
% 提供图标字体功能
\RequirePackage{fontawesome7}
\def\map{\faLocationDot}  % 定义位置图标别名
% 字符串处理宏包，提供了强大的字符串比较和替换功能
\RequirePackage{xstring}

% 提供更现代的命令定义方式，尤其适合定义参数形式复杂的命令
\RequirePackage{xparse}

\setlength{\columnsep}{3cm}     % 双栏间距设成 3cm
\pagestyle{empty}               % 页面不显示页码和页眉页脚
\linespread{1.25}               % 行距放大到 1.25 倍     
\AtBeginDocument{\zihao{4}}     % 文档开始时默认字号设成四号

% 颜色
\definecolor{background-color}{HTML}{fffee8}      % 背景颜色设置为暖黄色，接近纸张或便签纸背景色
\definecolor{titlepage-color}{HTML}{fffbb4}       % 标题页背景颜色设置为浅黄色，稍微亮一些以突出标题页
\definecolor{date-color}{HTML}{454545}            % 日期颜色设置为深灰色，提供良好的对比度和可读性
\definecolor{weekday-color}{HTML}{454545}         % 星期几颜色
\definecolor{map-color}{HTML}{454545}             % 位置图标颜色
\definecolor{weather-color}{HTML}{454545}         % 天气图标颜色

% 背景
\def\SpiralNumber{16}           % 线圈数
\def\GridColor{black!100}       % 网格线颜色
\def\ShadowXshift{0.5ex}        % 阴影水平偏移
\def\ShadowYshift{-0.5ex}       % 阴影垂直偏移

% 定义一个名为 spiral 的可复用图形，用渐变矩形和双线椭圆弧模拟“螺旋装订线圈”的一个小单元
\tikzset{%
  spiral/.pic={
    \draw[
      draw=black,
      left color=black!70,
      right color=black!70,
      middle color=gray!40
      ]
      (-1.1,-0.35) rectangle ++(10pt,10pt);
    \draw[
      draw=black,
      left color=black!70,
      right color=black!60,
      middle color=gray!40
      ]
      (-1.77,-0.35) rectangle ++(10pt,10pt);
    \draw[
      double=gray!80,
      double distance=1pt,
      ]
      (-1,-0.2) arc (40:-220:10pt and 2pt);
    \draw[
      double=gray!80,
      double distance=1pt,
      ]
      (-1,-0.05) arc (40:-220:10pt and 2pt);
  }
}


% 在每一页的背景上，画出左右两张带圆角和阴影的浅色纸页；
% 在纸页上画淡淡的横线；在顶部画较粗的分隔线；
% 然后在中间均匀摆上一列线圈，让整页看起来像一本摊开的线圈日记本。
\def\SpiralPosition{%
  ([xshift=36pt, yshift=3pt+2.5cm-\Valor*(\textheight+2.5cm)/(\SpiralNumber-1)]current page text area.north)
}
\RequirePackage{eso-pic}    %允许在页面输出时，把东西加到页面前景或背景上
\AddToShipoutPictureBG{%    把大括号里的内容，添加到每一页输出时的背景层
  \begin{tikzpicture}[remember picture,overlay]   % 以 TikZ 绘图，remember picture 和 overlay 选项允许在页面上任意位置绘制
    % draw frame
    \draw[rounded corners=10pt,fill=background-color,drop shadow={shadow xshift=\ShadowXshift, shadow yshift=\ShadowYshift}]
      ([xshift=-30pt,yshift=20pt+2.5cm]current page text area.north west) rectangle
      ([xshift=-2pt,yshift=-20pt]current page text area.south);
    \draw[rounded corners=10pt,fill=background-color,drop shadow={shadow xshift=\ShadowXshift, shadow yshift=\ShadowYshift}]
      ([xshift=30pt,yshift=-20pt]current page text area.south east) rectangle
      ([xshift=2pt,yshift=20pt+2.5cm]current page text area.north);
    % draw lines
    \draw[\GridColor,opacity=0.3,shift={(0,0.62\baselineskip)}]
          ([xshift=-30pt]current page text area.north west) grid[step=\baselineskip,xstep=0]
          ([xshift=-2pt]current page text area.south);
    \draw[\GridColor,opacity=0.3,shift={(0,0.62\baselineskip)}]
          ([xshift=30pt]current page text area.south east) grid[step=\baselineskip,xstep=0]
          ([xshift=2pt]current page text area.north);
    % top thick line
    \draw[black!70,line width=1pt]
          ([xshift=-30pt,yshift=0.7em]current page text area.north west) --
          ([xshift=-2pt,yshift=0.7em]current page text area.north);
    \draw[black!70,line width=1pt]
          ([xshift=30pt,yshift=0.7em]current page text area.north east) --
          ([xshift=2pt,yshift=0.7em]current page text area.north);
    % draw middle spiral
    \foreach \Valor in {0,1,...,\numexpr\SpiralNumber-1\relax}
      \pic at \SpiralPosition {spiral};
  \end{tikzpicture}
}

\DTMsavedate{currentdate}{\year-\month-\day}
\NewExpandableDocumentCommand{\getYear}{}{\DTMfetchyear{currentdate}}
\NewExpandableDocumentCommand{\getMonth}{}{\DTMfetchmonth{currentdate}}
\NewExpandableDocumentCommand{\getDay}{}{\DTMfetchday{currentdate}}

%COMMAND WEEKDAY
\newcommand\diary@EnDoWToCHDow[1]{%
	\IfStrEqCase{#1}{%
		{Sun}{星期日}
		{Mon}{星期一}
		{Tue}{星期二}
		{Wed}{星期三}
		{Thu}{星期四}
		{Fri}{星期五}
		{Sat}{星期六}
	}
}

%COMMAND WEEKDAY
\newcommand\diary@numToCHDow[1]{%
	\IfStrEqCase{#1}{%
		{0}{星期一}
		{1}{星期二}
		{2}{星期三}
		{3}{星期四}
		{4}{星期五}
		{5}{星期六}
		{6}{星期日}
	}
}

% default value
\def\diary@province{}           % 省份默认空字符串，用户可以通过 \Address 命令设置
\def\diary@city{}               % 城市默认空字符串，用户可以通过 \Address 命令设置
\def\diary@beginYear{}          % 起始年份默认空字符串，用户可以通过 \BeginAt 命令设置
\def\diary@beginMonth{}         % 起始月份默认空字符串，用户可以通过 \BeginAt 命令设置
\def\diary@beginDay{}           % 起始日期默认空字符串，用户可以通过 \BeginAt 命令设置
\def\diary@endYear{}            % 结束年份默认空字符串，用户可以通过 \EndAt 命令设置
\def\diary@endMonth{}           % 结束月份默认空字符串，用户可以通过 \EndAt 命令设置
\def\diary@endDay{}             % 结束日期默认空字符串，用户可以通过 \EndAt 命令设置
\def\@title{}                   % 标题默认空字符串，用户可以通过 \title 命令设置
\def\@author{}                  % 作者默认空字符串，用户可以通过 \author 命令设置
\def\diary@weather{\faSun[regular]}      % 天气图标默认是晴天，用户可以通过 \Date 命令的可选参数设置       

% 定义用户接口命令
\NewDocumentCommand{\Address}{O{江苏} O{苏州}}{%
  \def\diary@province{#1}%
  \def\diary@city{#2}%
}
\NewDocumentCommand{\BeginAt}{O{2026} O{01} O{01}}{%
  \def\diary@beginYear{#1}%
  \def\diary@beginMonth{#2}%
  \def\diary@beginDay{#3}%
}
\NewDocumentCommand{\EndAt}{O{2026} O{12} O{31}}{%
  \def\diary@endYear{#1}%
  \def\diary@endMonth{#2}%
  \def\diary@endDay{#3}%
}

% 新建一个 LaTeX 计数器，名字叫 diary，用来记录日记的篇数，每调用一次 \Date 命令就自增 1，并在页面底部显示当前是第几篇日记。
\newcounter{diary}

% 定义 \Date 命令，接受四个参数：年、月、日和可选的图标。
% \Date{year}{month}{day}[icon]
\NewDocumentCommand{\Date}{m m m O{}}{%
  \ifx#4\empty
  \else
    \def\diary@weather{#4}%
  \fi
  \stepcounter{diary}%
  \newpage%
  \begin{tikzpicture}[remember picture,overlay,black!80!yellow]
    \DTMsavedate{mydate}{#1-#2-#3}% 保存当前日期
    \if@firstcolumn
      \node[anchor=north east] at ([xshift=-2.5em,yshift=2.5cm]current page text area.north) (day)
        {\color{date-color}\fontsize{50}{60}\selectfont #3};%
      \draw[line width=2pt,date-color]
        ($(day.north west)+(-8pt,0)$) --
        ($(day.south west)+(-8pt,0)$);%
      \node[anchor=north east,left=16pt of day,yshift=9pt] (month)
        {\color{date-color}\zihao{4}#2 月};%
      \node[anchor=south east,left=16pt of day,yshift=-9pt] (weekday)
        {\color{weekday-color}\zihao{4}\diary@numToCHDow{\DTMfetchdow{mydate}}};%
      \node[anchor=south east,left=46pt of day,yshift=9pt] (year)
        {\color{date-color}\zihao{4}#1 年};%
      \node[left=8.0cm of day.east,anchor=center] (location)
        {\color{map-color}\map\ \ifx\diary@province\empty\else\diary@province•\fi\diary@city};%
      \node[left=10.5cm of day.east]
        {\color{weather-color}\huge\diary@weather};%
      \node at ($(current page text area.south)+(-0.25\textwidth-16pt,-8pt)$)
        {\color{date-color}第 \thediary 篇};%
    \else
      \node[anchor=north west] at ([xshift=2.5em,yshift=2.5cm]current page text area.north) (day)
        {\color{date-color}\fontsize{50}{60}\selectfont #3};%
      \draw[line width=2pt,date-color]
        ($(day.north east)+(8pt,0)$) --
        ($(day.south east)+(8pt,0)$);%
      \node[anchor=north west,right=16pt of day,yshift=9pt] (month)
        {\color{date-color}\zihao{4}#2 月};%
      \node[anchor=south west,right=16pt of day,yshift=-9pt] (weekday)
        {\color{weekday-color}\zihao{4}\diary@numToCHDow{\DTMfetchdow{mydate}}};%
      \node[anchor=north west,right=46pt of day,yshift=9pt] (year)
        {\color{date-color}\zihao{4}#1 年};%
      \node[right=8.0cm of day.west,anchor=center] (location)
        {\color{map-color}\map\ \ifx\diary@province\empty\else\diary@province•\fi\diary@city};%
      \node[right=10.5cm of day.west]
        {\color{weather-color}\huge\diary@weather};%
      \node at ($(current page text area.south)+(0.25\textwidth+16pt,-8pt)$)
        {\color{date-color}第 \thediary 篇};%
    \fi
  \end{tikzpicture}%
}

% \DTMshortweekdayname{\DTMfetchdow{mydate}}
% \DTMfetchdow{mydate} 从通过 \DTMsavedate 保存的日期中，提取星期几（0-6，0=周一，6=周日）。

% ==================== 标题页字体 =======================
% 设置两个状态标志用来记录用户有没有手动设置过对应字体，
% 如果用户调用了 \TitleCJKFont 或 \TitleFont 来设置标题页的字体，
% 就把对应的状态标志设为 1；在 \maketitle 中根据状态标志来决定是否切换到用户指定的字体。
\def\diary@differentTitleCJKFont{}
\def\diary@differentTitleFont{}
\newcommand\TitleCJKFont[1]{%
  \newCJKfontfamily\diary@titleCJKfont{#1}%
  \def\diary@differentTitleCJKFont{1}%
}%
\newcommand\TitleFont[1]{%
  \newfontfamily\diary@titlefont{#1}%
  \def\diary@differentTitleFont{1}%
}%

% titlepage
\renewcommand\maketitle{%
  % 覆盖原来的背景
  \begin{tikzpicture}[remember picture,overlay]
    % draw frame
    \draw[rounded corners=10pt,fill=titlepage-color,drop shadow={shadow xshift=\ShadowXshift, shadow yshift=\ShadowYshift}]
      ([xshift=-30pt,yshift=20pt+2.5cm]current page text area.north west) rectangle
      ([xshift=-2pt,yshift=-20pt]current page text area.south);
    % draw middle spiral
    \foreach \Valor in {0,1,...,\numexpr\SpiralNumber-1\relax}
      \pic at \SpiralPosition {spiral};
  \end{tikzpicture}%
  \begin{center}
    \ifx\diary@differentTitleCJKFont\empty\else\diary@titleCJKfont\fi%
    \ifx\diary@differentTitleFont\empty\else\diary@titlefont\fi%
    {\zihao{0}\@title}\par%
    \vspace{5em}%
    {\zihao{2}\hspace*{0em}\@author}\par%
    \vspace{7em}%
    \diary@beginYear 年 \diary@beginMonth 月 \diary@beginDay 日\par%
    \hspace*{-1.5em}至\hspace{0.5em}%
    \diary@endYear 年\diary@endMonth 月\diary@endDay 日%
  \end{center}
  \newpage%
}%

% 添加主题居中命令
\newcommand{\Theme}[1]{%
	\begin{center}%
		\vspace{-2em}
		#1%
		\vspace{-0.55em}
	\end{center}%
  \par
}