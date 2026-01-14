oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin_mocha.omp.json' | Invoke-Expression

Import-Module -Name Terminal-Icons
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -EditMode Windows

Set-PSReadLineOption -Colors @{
    Command            = '#89b4fa'
    Parameter          = '#94e2d5'
    Operator           = '#89dceb'
    InlinePrediction   = '#6c7086'
}

Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
