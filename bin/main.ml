let () =
  let open Vocab in
  init();
  let list = load_list "Vocabulaire" in
  (* add_mode Format.std_formatter list; *)
  train_mode Format.std_formatter list
