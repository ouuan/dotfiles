alias notes="pushd ~/Notes && vim +\"lua require'neuron/telescope'.find_zettels()\""
alias note="pushd ~/Notes && vim +\"lua require'neuron/cmd'.new_edit(require'neuron/config'.neuron_dir)\""
alias viewnote='port & neuron -d ~/Notes/notes gen -w -s :$PORT'
