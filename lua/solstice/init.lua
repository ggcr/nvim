--- @diagnostic disable: undefined-global

--- @class SolsticeConfig
--- @field termguicolors boolean?
--- @field terminal_colors boolean?
--- @field transparent boolean?
--- @field overrides table<string, table>?
--- @field palette_overrides table<string, string>?

local Solstice = {}

Solstice.config = {
    termguicolors = true,
    terminal_colors = true,
    transparent = true,
    palette_overrides = {},
    overrides = {},
}

local p = require("solstice.palette")

local function bg(color)
    if Solstice.config.transparent then
        return nil
    end

    return color
end

local function get_groups()
    local config = Solstice.config

    for color, hex in pairs(config.palette_overrides) do
        p[color] = hex
    end

    if config.terminal_colors then
        local term_colors = {
            p.base02,
            p.red,
            p.green,
            p.yellow,
            p.blue,
            p.magenta,
            p.cyan,
            p.base2,
            p.base03,
            p.orange,
            p.base01,
            p.base00,
            p.base0,
            p.violet,
            p.base1,
            p.base3,
        }

        for index, color in ipairs(term_colors) do
            vim.g["terminal_color_" .. (index - 1)] = color
        end
    end

    local groups = {
        -- Links and local compatibility shims from the old Vimscript wrapper.
        Boolean = { link = "Constant" },
        Character = { link = "Constant" },
        Conditional = { link = "Statement" },
        CursorLineFold = { link = "Folded" },
        CursorLineSign = { link = "SignColumn" },
        Debug = { link = "Special" },
        Define = { link = "PreProc" },
        Delimiter = { link = "Normal" },
        Exception = { link = "Statement" },
        Float = { link = "Constant" },
        Function = { link = "Identifier" },
        Ignore = { fg = p.base03 },
        IncSearch = { link = "CurSearch" },
        Include = { link = "PreProc" },
        Keyword = { link = "Statement" },
        Label = { link = "Statement" },
        LineNrAbove = { link = "LineNr" },
        LineNrBelow = { link = "LineNr" },
        Macro = { link = "PreProc" },
        Number = { link = "Constant" },
        Operator = { link = "Statement" },
        PopupNotification = { link = "WarningMsg" },
        PreCondit = { link = "PreProc" },
        Repeat = { link = "Statement" },
        SpecialChar = { link = "Special" },
        SpecialComment = { link = "Special" },
        SpecialKey = { fg = p.base00 },
        StatusLineTerm = { link = "StatusLine" },
        StatusLineTermNC = { link = "StatusLineNC" },
        StorageClass = { link = "Type" },
        String = { link = "Constant" },
        Structure = { link = "Type" },
        Terminal = { link = "Normal" },
        Typedef = { link = "Type" },
        WinSeparator = { link = "VertSplit" },
        cppModifier = { link = "cStorageClass" },

        -- Editor.
        Normal = { fg = p.normal, bg = bg(p.base03) },
        NormalNC = { fg = p.normal, bg = bg(p.base03) },
        Bold = { bold = true },
        Italic = { italic = true },
        Underlined = { fg = p.violet, underline = true },
        Cursor = { fg = p.base03, bg = p.base0 },
        CursorIM = { fg = p.base03, bg = p.red },
        lCursor = { link = "Cursor" },
        CursorLine = { bg = p.base02 },
        CursorColumn = { bg = p.base02 },
        CursorLineNr = { link = "LineNr" },
        LineNr = { fg = p.green_original, bg = bg(p.base02) },
        SignColumn = { link = "LineNr" },
        ColorColumn = { bg = p.base02 },
        EndOfBuffer = { fg = p.base02 },
        NonText = { fg = p.base00 },
        Conceal = { fg = p.blue },
        VertSplit = { fg = p.border, bg = bg(p.base03) },
        Whitespace = { fg = p.base02 },

        -- Floating windows.
        NormalFloat = { fg = p.base0, bg = bg(p.base02) },
        FloatBorder = { fg = p.border, bg = bg(p.base02) },
        FloatTitle = { fg = p.orange, bg = bg(p.base02), bold = true },
        FloatShadow = { bg = p.base03, blend = 80 },
        FloatShadowThrough = { bg = p.base03, blend = 100 },
        MsgArea = { fg = p.base0, bg = bg(p.base03) },

        -- Window bar.
        WinBar = { fg = p.base1, bg = bg(p.base02), bold = true },
        WinBarNC = { fg = p.base00, bg = bg(p.base02) },

        -- Folds.
        Folded = { fg = p.base0, bg = p.base02, underline = true, sp = p.base03 },
        FoldColumn = { fg = p.border, bg = bg(p.base03) },

        -- Search.
        Search = { fg = p.base03, bg = p.yellow },
        CurSearch = { fg = p.base03, bg = p.orange },

        -- Selection.
        Visual = { bg = p.base02 },
        VisualNOS = { bg = p.base02, bold = true },
        MatchParen = { fg = p.red, bg = p.base01, bold = true },

        -- Popup menu.
        Pmenu = { fg = p.base0, bg = bg(p.base02) },
        PmenuSel = { fg = p.base03, bg = p.base1 },
        PmenuKind = { fg = p.yellow },
        PmenuKindSel = { fg = p.base03, bg = p.base1 },
        PmenuMatch = { fg = p.blue, bold = true },
        PmenuMatchSel = { fg = p.blue, bg = p.base1, bold = true },
        PmenuExtra = { fg = p.base01 },
        PmenuExtraSel = { fg = p.base03, bg = p.base1 },
        PmenuSbar = { bg = p.base0 },
        PmenuThumb = { bg = p.base03 },

        -- Status line.
        StatusLine = { fg = p.base1, bg = p.statusline_active },
        StatusLineNC = { fg = p.base00, bg = p.statusline },

        -- Tab line.
        TabLineFill = { fg = p.base0, bg = p.base02, underline = true, sp = p.base0 },
        TabLine = { fg = p.base0, bg = p.base02, underline = true, sp = p.base0 },
        TabLineSel = { fg = p.base03, bg = p.base2, underline = true, sp = p.base0 },

        -- Title bar.
        TitleBar = { fg = p.orange, bold = true },
        TitleBarNC = { fg = p.base00 },

        -- Wild menu.
        WildMenu = { fg = p.base03, bg = p.base2 },

        -- Messages.
        ModeMsg = { fg = p.blue },
        MoreMsg = { fg = p.blue },
        Question = { fg = p.cyan, bold = true },
        ErrorMsg = { fg = p.red, reverse = true },
        WarningMsg = { fg = p.red, bold = true },

        -- Toolbar.
        ToolbarButton = { fg = p.base1 },
        ToolbarLine = {},

        -- Title.
        Title = { fg = p.orange, bold = true },
        Directory = { fg = p.blue },
        Tag = { fg = p.red, bold = true },

        -- VCS state.
        Added = { fg = p.green },
        Changed = { fg = p.yellow },
        Removed = { fg = p.red },

        -- Gitsigns.
        GitSignsStagedAdd = { link = "Added" },
        GitSignsStagedChange = { link = "Changed" },
        GitSignsStagedDelete = { link = "Removed" },
        GitSignsStagedChangedelete = { link = "Changed" },
        GitSignsStagedTopdelete = { link = "Removed" },
        GitSignsStagedUntracked = { link = "Added" },
        GitSignsStagedAddNr = { link = "Added" },
        GitSignsStagedChangeNr = { link = "Changed" },
        GitSignsStagedDeleteNr = { link = "Removed" },
        GitSignsStagedChangedeleteNr = { link = "Changed" },
        GitSignsStagedTopdeleteNr = { link = "Removed" },
        GitSignsStagedUntrackedNr = { link = "Added" },
        GitSignsStagedAddCul = { link = "Added" },
        GitSignsStagedChangeCul = { link = "Changed" },
        GitSignsStagedDeleteCul = { link = "Removed" },
        GitSignsStagedChangedeleteCul = { link = "Changed" },
        GitSignsStagedTopdeleteCul = { link = "Removed" },
        GitSignsStagedUntrackedCul = { link = "Added" },
        GitSignsStagedAddLn = { link = "DiffAdd" },
        GitSignsStagedChangeLn = { link = "DiffChange" },
        GitSignsStagedChangedeleteLn = { link = "DiffChange" },
        GitSignsStagedUntrackedLn = { link = "DiffAdd" },

        -- Diff.
        DiffAdd = { fg = p.green, bg = p.base02, bold = true, sp = p.green },
        DiffChange = { fg = p.yellow, bg = p.base02, bold = true, sp = p.yellow },
        DiffDelete = { fg = p.red, bg = p.base02, bold = true },
        DiffText = { fg = p.blue, bg = p.base02, bold = true, sp = p.blue },

        -- Spell.
        SpellBad = { sp = p.red, undercurl = true },
        SpellCap = { sp = p.red, undercurl = true },
        SpellLocal = { sp = p.cyan, undercurl = true },
        SpellRare = { sp = p.yellow, undercurl = true },

        -- Syntax.
        Comment = { fg = p.base01 },
        Constant = { fg = p.cyan },
        Identifier = { fg = p.blue },
        Statement = { fg = p.green },
        PreProc = { fg = p.orange },
        Type = { fg = p.yellow },
        Special = { fg = p.red },
        Error = { fg = p.red, bold = true },
        Todo = { fg = p.magenta, bold = true },
        PreInsert = { fg = p.base01 },

        -- Quickfix.
        QuickFixLine = { bg = p.base02, bold = true },
        qfFileName = { fg = p.blue },
        qfLineNr = { fg = p.yellow },

        -- Debug.
        debugPC = { bg = p.base02 },
        debugBreakpoint = { fg = p.red, bg = p.base02 },

        -- DAP.
        DapStoppedSign = { fg = p.green, bg = p.base02 },

        -- Diff filetype.
        diffAdded = { link = "Statement" },
        diffRemoved = { fg = p.red },
        diffChanged = { fg = p.yellow },
        diffFile = { fg = p.orange },
        diffNewFile = { fg = p.yellow },
        diffOldFile = { fg = p.orange },
        diffLine = { link = "Identifier" },
        diffIndexLine = { fg = p.cyan },

        -- Git commit.
        gitcommitComment = { fg = p.base01 },
        gitcommitUntracked = { link = "gitcommitComment" },
        gitcommitDiscarded = { link = "gitcommitComment" },
        gitcommitSelected = { link = "gitcommitComment" },
        gitcommitUnmerged = { fg = p.green, bold = true },
        gitcommitOnBranch = { fg = p.base01, bold = true },
        gitcommitBranch = { fg = p.magenta, bold = true },
        gitcommitNoBranch = { link = "gitcommitBranch" },
        gitcommitDiscardedType = { fg = p.red },
        gitcommitSelectedType = { fg = p.green },
        gitcommitHeader = { fg = p.base01 },
        gitcommitUntrackedFile = { fg = p.cyan, bold = true },
        gitcommitDiscardedFile = { fg = p.red, bold = true },
        gitcommitSelectedFile = { fg = p.green, bold = true },
        gitcommitUnmergedFile = { fg = p.yellow, bold = true },
        gitcommitFile = { fg = p.base0, bold = true },
        gitcommitDiscardedArrow = { link = "gitcommitDiscardedFile" },
        gitcommitSelectedArrow = { link = "gitcommitSelectedFile" },
        gitcommitUnmergedArrow = { link = "gitcommitUnmergedFile" },

        -- Markdown.
        markdownH1 = { fg = p.orange },
        markdownH2 = { fg = p.yellow },
        markdownH3 = { fg = p.green },
        markdownH4 = { fg = p.cyan },
        markdownH5 = { fg = p.blue },
        markdownH6 = { fg = p.violet },
        markdownHeadingDelimiter = { fg = p.yellow, bold = true },
        markdownCode = { fg = p.yellow },
        markdownCodeBlock = { fg = p.yellow },
        markdownLinkText = { fg = p.blue, underline = true },

        -- render-markdown.nvim.
        RenderMarkdownH1 = { fg = p.orange },
        RenderMarkdownH2 = { fg = p.yellow },
        RenderMarkdownH3 = { fg = p.green },
        RenderMarkdownH4 = { fg = p.cyan },
        RenderMarkdownH5 = { fg = p.blue },
        RenderMarkdownH6 = { fg = p.violet },
        RenderMarkdownH1Bg = { bg = p.base02 },
        RenderMarkdownH2Bg = { bg = p.base02 },
        RenderMarkdownH3Bg = { bg = p.base02 },
        RenderMarkdownH4Bg = { bg = p.base02 },
        RenderMarkdownH5Bg = { bg = p.base02 },
        RenderMarkdownH6Bg = { bg = p.base02 },
        RenderMarkdownCode = { bg = p.base02 },
        RenderMarkdownCodeBorder = { link = "RenderMarkdownCode" },
        RenderMarkdownCodeFallback = { fg = p.base00 },
        RenderMarkdownCodeInline = { fg = p.yellow, bg = p.base02 },
        RenderMarkdownCodeInfo = { fg = p.base01 },
        RenderMarkdownInlineHighlight = { link = "RenderMarkdownCodeInline" },
        RenderMarkdownQuote = { fg = p.base01 },
        RenderMarkdownQuote1 = { link = "RenderMarkdownQuote" },
        RenderMarkdownQuote2 = { link = "RenderMarkdownQuote" },
        RenderMarkdownQuote3 = { link = "RenderMarkdownQuote" },
        RenderMarkdownQuote4 = { link = "RenderMarkdownQuote" },
        RenderMarkdownQuote5 = { link = "RenderMarkdownQuote" },
        RenderMarkdownQuote6 = { link = "RenderMarkdownQuote" },
        RenderMarkdownBullet = { fg = p.base00 },
        RenderMarkdownDash = { fg = p.base02 },
        RenderMarkdownSign = { link = "SignColumn" },
        RenderMarkdownIndent = { link = "Whitespace" },
        RenderMarkdownHtmlComment = { link = "Comment" },
        RenderMarkdownUnchecked = { fg = p.base01 },
        RenderMarkdownChecked = { fg = p.green },
        RenderMarkdownTodo = { fg = p.yellow },
        RenderMarkdownTableHead = { fg = p.yellow, bold = true },
        RenderMarkdownTableRow = { fg = p.base01 },
        RenderMarkdownLink = { fg = p.blue },
        RenderMarkdownLinkTitle = { fg = p.blue, underline = true },
        RenderMarkdownWikiLink = { link = "RenderMarkdownLink" },
        RenderMarkdownMath = { fg = p.blue },
        RenderMarkdownSuccess = { link = "DiagnosticOk" },
        RenderMarkdownInfo = { link = "DiagnosticInfo" },
        RenderMarkdownHint = { link = "DiagnosticHint" },
        RenderMarkdownWarn = { link = "DiagnosticWarn" },
        RenderMarkdownError = { link = "DiagnosticError" },

        -- CSV.
        csvCol0 = { fg = p.orange },
        csvCol1 = { fg = p.yellow },
        csvCol2 = { fg = p.green },
        csvCol3 = { fg = p.cyan },
        csvCol4 = { fg = p.blue },
        csvCol5 = { fg = p.violet },
        csvCol6 = { fg = p.magenta },
        csvCol7 = { fg = p.base00 },
        csvCol8 = { fg = p.red },

        -- fzf-lua.
        FzfLuaNormal = { fg = p.base0, bg = p.picker },
        FzfLuaBorder = { fg = p.border, bg = p.picker },
        FzfLuaTitle = { fg = p.orange, bg = p.picker, bold = true },
        FzfLuaTitleFlags = { fg = p.base00, bg = p.picker },
        FzfLuaBackdrop = { bg = bg(p.base03) },
        FzfLuaHelpNormal = { link = "FzfLuaNormal" },
        FzfLuaHelpBorder = { link = "FzfLuaBorder" },
        FzfLuaPreviewNormal = { fg = p.base0, bg = p.picker },
        FzfLuaPreviewBorder = { fg = p.border, bg = p.picker },
        FzfLuaPreviewTitle = { fg = p.orange, bg = p.picker, bold = true },
        FzfLuaCursor = { link = "Cursor" },
        FzfLuaCursorLine = { bg = p.base02 },
        FzfLuaCursorLineNr = { link = "LineNr" },
        FzfLuaSearch = { link = "IncSearch" },
        FzfLuaScrollBorderEmpty = { link = "FzfLuaBorder" },
        FzfLuaScrollBorderFull = { link = "FzfLuaBorder" },
        FzfLuaScrollFloatEmpty = { link = "PmenuSbar" },
        FzfLuaScrollFloatFull = { bg = p.base03 },
        FzfLuaDirIcon = { link = "Directory" },
        FzfLuaDirPart = { link = "Comment" },
        FzfLuaFilePart = { fg = p.base0 },
        FzfLuaHeaderBind = { fg = p.yellow },
        FzfLuaHeaderText = { fg = p.orange },
        FzfLuaPathColNr = { fg = p.cyan },
        FzfLuaPathLineNr = { fg = p.green },
        FzfLuaLivePrompt = { fg = p.orange },
        FzfLuaLiveSym = { fg = p.orange },
        FzfLuaBufId = { fg = p.base01 },
        FzfLuaBufName = { link = "Directory" },
        FzfLuaBufLineNr = { link = "LineNr" },
        FzfLuaBufNr = { fg = p.base00 },
        FzfLuaBufFlagCur = { fg = p.orange },
        FzfLuaBufFlagAlt = { fg = p.blue },
        FzfLuaTabTitle = { fg = p.yellow, bold = true },
        FzfLuaTabMarker = { fg = p.green, bold = true },
        FzfLuaCmdEx = { link = "Statement" },
        FzfLuaCmdBuf = { link = "Added" },
        FzfLuaCmdGlobal = { link = "Directory" },
        FzfLuaFzfNormal = { fg = p.base01, bg = p.picker },
        FzfLuaFzfCursorLine = { fg = p.base0, bg = p.base02, bold = true },
        FzfLuaFzfMatch = { fg = p.blue, bold = true },
        FzfLuaFzfBorder = { link = "FzfLuaBorder" },
        FzfLuaFzfScrollbar = { link = "FzfLuaBorder" },
        FzfLuaFzfSeparator = { link = "FzfLuaBorder" },
        FzfLuaFzfGutter = { link = "FzfLuaNormal" },
        FzfLuaFzfHeader = { link = "FzfLuaTitle" },
        FzfLuaFzfInfo = { fg = p.base01 },
        FzfLuaFzfPointer = { fg = p.orange },
        FzfLuaFzfMarker = { fg = p.green },
        FzfLuaFzfSpinner = { fg = p.orange },
        FzfLuaFzfPrompt = { fg = p.orange },
        FzfLuaFzfQuery = { fg = p.base0 },

        -- Telescope.
        TelescopeNormal = { fg = p.base0, bg = p.picker },
        TelescopeBorder = { fg = p.border, bg = p.picker },
        TelescopePromptNormal = { fg = p.base0, bg = p.picker },
        TelescopePromptBorder = { fg = p.border, bg = p.picker },
        TelescopePromptPrefix = { fg = p.orange },
        TelescopePromptCounter = { fg = p.base01 },
        TelescopePromptTitle = { fg = p.orange, bold = true },
        TelescopeResultsNormal = { fg = p.base01, bg = p.picker },
        TelescopeResultsTitle = { fg = p.orange, bold = true },
        TelescopePreviewNormal = { fg = p.base0, bg = p.picker },
        TelescopePreviewBorder = { fg = p.border, bg = p.picker },
        TelescopePreviewTitle = { fg = p.orange, bold = true },
        TelescopeSelection = { fg = p.base0, bg = p.base02, bold = true },
        TelescopeSelectionCaret = { fg = p.orange, bg = p.base02 },
        TelescopeMultiSelection = { fg = p.green },
        TelescopeMultiIcon = { fg = p.green },
        TelescopeMatching = { fg = p.blue, bold = true },

        -- blink.cmp.
        BlinkCmpMenu = { fg = p.base0, bg = bg(p.base02) },
        BlinkCmpMenuBorder = { fg = p.border, bg = bg(p.base02) },
        BlinkCmpMenuSelection = { bg = p.base02, bold = true },
        BlinkCmpScrollBarThumb = { bg = p.base03 },
        BlinkCmpScrollBarGutter = {},
        BlinkCmpLabel = { fg = p.base0 },
        BlinkCmpLabelMatch = { fg = p.blue, bold = true },
        BlinkCmpLabelDeprecated = { fg = p.base01, strikethrough = true },
        BlinkCmpLabelDetail = { fg = p.base00 },
        BlinkCmpLabelDescription = { fg = p.base00 },
        BlinkCmpSource = { fg = p.base01 },
        BlinkCmpGhostText = { fg = p.base01 },
        BlinkCmpDoc = { fg = p.base0, bg = bg(p.base02) },
        BlinkCmpDocBorder = { fg = p.border, bg = bg(p.base02) },
        BlinkCmpDocSeparator = { fg = p.base02, bg = bg(p.base02) },
        BlinkCmpDocCursorLine = { bg = p.base02 },
        BlinkCmpSignatureHelp = { fg = p.base0, bg = bg(p.base02) },
        BlinkCmpSignatureHelpBorder = { fg = p.border, bg = bg(p.base02) },
        BlinkCmpSignatureHelpActiveParameter = { fg = p.orange, bold = true },
        BlinkCmpKind = { fg = p.yellow },
        BlinkCmpKindFunction = { link = "Identifier" },
        BlinkCmpKindMethod = { link = "Identifier" },
        BlinkCmpKindConstructor = { link = "Type" },
        BlinkCmpKindClass = { link = "Type" },
        BlinkCmpKindInterface = { link = "Type" },
        BlinkCmpKindStruct = { link = "Type" },
        BlinkCmpKindEnum = { link = "Type" },
        BlinkCmpKindTypeParameter = { link = "Type" },
        BlinkCmpKindVariable = { link = "Normal" },
        BlinkCmpKindText = { link = "Normal" },
        BlinkCmpKindModule = { link = "Directory" },
        BlinkCmpKindConstant = { link = "Constant" },
        BlinkCmpKindValue = { link = "Constant" },
        BlinkCmpKindEnumMember = { link = "Constant" },
        BlinkCmpKindKeyword = { link = "Statement" },
        BlinkCmpKindEvent = { link = "Statement" },
        BlinkCmpKindOperator = { link = "Statement" },
        BlinkCmpKindProperty = { fg = p.base00 },
        BlinkCmpKindField = { fg = p.base00 },
        BlinkCmpKindSnippet = { link = "PreProc" },
        BlinkCmpKindFile = { link = "Directory" },
        BlinkCmpKindFolder = { link = "Directory" },
        BlinkCmpKindColor = { link = "Constant" },
        BlinkCmpKindReference = { link = "Constant" },
        BlinkCmpKindUnit = { link = "Directory" },

        -- mini.statusline.
        MiniStatuslineModeNormal = { fg = p.green_original, bg = p.statusline_active },
        MiniStatuslineModeInsert = { fg = p.blue, bg = p.statusline_active },
        MiniStatuslineModeVisual = { fg = p.violet, bg = p.statusline_active },
        MiniStatuslineModeReplace = { fg = p.red, bg = p.statusline_active },
        MiniStatuslineModeCommand = { fg = p.yellow, bg = p.statusline_active },
        MiniStatuslineModeOther = { fg = p.magenta, bg = p.statusline_active },
        MiniStatuslineDevinfo = { fg = p.base00, bg = p.statusline_active },
        MiniStatuslineFilename = { fg = p.base1, bg = p.statusline_active },
        MiniStatuslineFileinfo = { fg = p.base00, bg = p.statusline_active },
        MiniStatuslineInactive = { fg = p.base01, bg = p.statusline },

        -- mini.starter.
        MiniStarterHeader = { fg = p.orange },
        MiniStarterFooter = { fg = p.orange },
        MiniStarterSection = { fg = p.yellow, bold = true },
        MiniStarterItem = { fg = p.base01 },
        MiniStarterItemBullet = { fg = p.base02 },
        MiniStarterItemPrefix = { fg = p.cyan },
        MiniStarterCurrent = { fg = p.base0, bg = p.base02, bold = true },
        MiniStarterQuery = { fg = p.yellow, bold = true },
        MiniStarterInactive = { fg = p.base02 },

        -- Treesitter.
        ["@comment"] = { link = "Comment" },
        ["@variable"] = { link = "Normal" },
        ["@variable.builtin"] = { fg = p.orange },
        ["@variable.parameter"] = { link = "Normal" },
        ["@variable.member"] = { link = "Normal" },
        ["@variable.member.lua"] = { link = "Normal" },
        ["@constant"] = { link = "Constant" },
        ["@constant.builtin"] = { link = "Constant" },
        ["@constant.macro"] = { link = "PreProc" },
        ["@module"] = { fg = p.blue },
        ["@label"] = { link = "Statement" },
        ["@string"] = { link = "Constant" },
        ["@string.escape"] = { link = "Special" },
        ["@character"] = { link = "Constant" },
        ["@number"] = { link = "Constant" },
        ["@number.float"] = { link = "Constant" },
        ["@boolean"] = { link = "Constant" },
        ["@function"] = { link = "Identifier" },
        ["@function.builtin"] = { link = "Identifier" },
        ["@function.call"] = { link = "Identifier" },
        ["@function.macro"] = { link = "PreProc" },
        ["@constructor"] = { link = "Type" },
        ["@keyword"] = { link = "Statement" },
        ["@keyword.conditional"] = { link = "Statement" },
        ["@keyword.repeat"] = { link = "Statement" },
        ["@keyword.return"] = { link = "Statement" },
        ["@keyword.operator"] = { link = "Statement" },
        ["@operator"] = { link = "Statement" },
        ["@type"] = { link = "Type" },
        ["@type.builtin"] = { link = "Type" },
        ["@property"] = { link = "Normal" },
        ["@punctuation.delimiter"] = { link = "Normal" },
        ["@punctuation.bracket"] = { link = "Normal" },
        ["@punctuation.special"] = { fg = p.base00 },
        ["@tag"] = { link = "Tag" },
        ["@tag.attribute"] = { fg = p.base00 },
        ["@tag.delimiter"] = { link = "Normal" },
        ["@markup.heading.1"] = { link = "RenderMarkdownH1" },
        ["@markup.heading.2"] = { link = "RenderMarkdownH2" },
        ["@markup.heading.3"] = { link = "RenderMarkdownH3" },
        ["@markup.heading.4"] = { link = "RenderMarkdownH4" },
        ["@markup.heading.5"] = { link = "RenderMarkdownH5" },
        ["@markup.heading.6"] = { link = "RenderMarkdownH6" },
        ["@markup.link"] = { fg = p.blue, underline = true },
        ["@markup.raw"] = { fg = p.yellow },
        ["@lsp.type.variable"] = { link = "Normal" },
        ["@lsp.type.variable.lua"] = { link = "Normal" },

        -- Diagnostics.
        DiagnosticError = { fg = p.red },
        DiagnosticWarn = { fg = p.yellow },
        DiagnosticInfo = { fg = p.blue },
        DiagnosticHint = { fg = p.cyan },
        DiagnosticOk = { fg = p.green_original },
        DiagnosticUnderlineError = { sp = p.red, undercurl = true },
        DiagnosticUnderlineWarn = { sp = p.yellow, undercurl = true },
        DiagnosticUnderlineInfo = { sp = p.blue, undercurl = true },
        DiagnosticUnderlineHint = { sp = p.cyan, undercurl = true },
        DiagnosticUnderlineOk = { sp = p.green_original, undercurl = true },
        DiagnosticDeprecated = { sp = p.red, strikethrough = true },
    }

    for group, hl in pairs(config.overrides) do
        if groups[group] then
            groups[group].link = nil
        end

        groups[group] = vim.tbl_extend("force", groups[group] or {}, hl)
    end

    return groups
end

--- @param config SolsticeConfig?
Solstice.setup = function(config)
    Solstice.config = vim.tbl_extend("force", Solstice.config, config or {})
end

Solstice.load = function()
    if vim.version().minor < 8 then
        vim.notify_once("solstice.nvim: nvim 0.8 or higher is needed")
        return
    end

    if Solstice.config.termguicolors then
        vim.o.termguicolors = true
    end

    vim.o.background = "dark"

    if vim.g.colors_name then
        vim.cmd.hi("clear")
    end

    if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
    end

    vim.g.colors_name = "solstice"

    local groups = get_groups()

    for group, settings in pairs(groups) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

return Solstice
