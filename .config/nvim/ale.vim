"""ALE
" disable linting while typing
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=1
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'
" let g:ale_php_phpmd_ruleset='cleancode,codesize,controversial,design,unusedcode'
let g:ale_linters = {'php': ['php', 'phpstan', 'langserver', 'phan']}
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
  \}
let g:ale_fix_on_save = 1
let g:ale_php_cs_fixer_executable = '/usr/local/bin/php-cs-fixer.phar'
let g:ale_php_phan_executable = '/usr/local/bin/phan.phar'
let g:ale_php_phpstan_executable = '/usr/local/bin/phpstan'
let g:ale_php_phpstan_use_global = 1
let g:ale_php_phpstan_level = 8
