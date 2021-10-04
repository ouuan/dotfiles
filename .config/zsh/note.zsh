alias notes="pushd ~/Notes && vim +\"lua require'neuron/telescope'.find_zettels()\""
alias note="pushd ~/Notes && vim +\"lua require'neuron/cmd'.new_edit(require'neuron/config'.neuron_dir)\""
alias viewnote='PORT=$(port) && (sleep 1 && bk firefox http://127.0.0.1:$PORT) & neuron -d ~/Notes/notes gen -w -s :$PORT'
