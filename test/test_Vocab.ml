let voc =
  let open Vocab in
  let un =
    { in_word = "Bonjour"; out_word = "Hello"; tries = ref 0; logs = ref [] }
  in
  {
    title = "Test";
    length = ref 1;
    list = ref [ un ];
    in_language = French;
    out_language = English;
  }
in
Vocab.save_list voc;
let l : Vocab.vocab_list = Vocab.load_list voc.title in
if l = voc then print_string "Yeah" else print_string "Nooo"
