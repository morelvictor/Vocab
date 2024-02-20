type language = French | English | German

type translation_unit = {
  in_word : string;
  out_word : string;
  tries : int ref;
  logs : (bool * float) list ref; (* (Fail/success * timestamp) *)
}

type vocab_list = {
  title : string;
  length : int ref;
  list : translation_unit list ref;
  in_language : language;
  out_language : language;
}

type mode = Edit | Train | Add

let gen_filename title = "/Users/victormorel/Vocab/" ^ title ^ ".voc"

let save_list list =
  let channel = list.title |> gen_filename |> open_out in
  Marshal.to_channel channel list [];
  flush channel

let load_list title : vocab_list =
  let channel = title |> gen_filename |> open_in in
  Marshal.from_channel channel

let pp_list fmt list = Format.fprintf fmt "Title: %s" list.title

let string_of_language = function
  | French -> "French"
  | English -> "English"
  | German -> "German"

let language_of_string = function
  | "fr" -> French
  | "en" -> English
  | "ge" -> German
  | _ -> failwith "NIY"

let pp_language fmt language =
  Format.fprintf fmt "%s" (string_of_language language)

let ask fmt what =
  Format.fprintf fmt "%s: " what;
  Format.print_flush ();
  read_line ()

let edit_mode fmt (list : vocab_list) = ignore (fmt, list)

let check fmt answered unit =
  let result = answered = unit.out_word in
  if result then Format.fprintf fmt "Correct@,"
  else Format.fprintf fmt "Echec %s -> %s@," unit.in_word unit.out_word;
  unit.logs := (result, Unix.time ()) :: !(unit.logs);
  incr unit.tries

let rec train_mode fmt (list : vocab_list) =
  if !(list.length) = 0 then failwith "Empty list"
  else
    let n = Random.int !(list.length) in
    let unit = List.nth !(list.list) n in
    let answered = ask fmt unit.in_word in
    if answered <> ":q" then (
      check fmt answered unit;
      train_mode fmt list)
    else save_list list

let rec add_mode fmt list =
  let in_word = ask fmt (Format.asprintf "%a" pp_language list.in_language) in
  if in_word <> ":q" then
    let out_word =
      ask fmt (Format.asprintf "%a" pp_language list.out_language)
    in
    let new_unit = { in_word; out_word; tries = ref 0; logs = ref [] } in
    if out_word <> ":q" then (
      list.list := new_unit :: !(list.list);
      incr list.length;
      add_mode fmt list)
    else save_list list
  else save_list list

let create_list fmt =
  let title = ask fmt "Title" in
  let in_language = ask fmt "In language" |> language_of_string in
  let out_language = ask fmt "Out language" |> language_of_string in
  { title; length = ref 0; list = ref []; in_language; out_language }

let start_mode = function
  | Edit -> edit_mode
  | Train -> train_mode
  | Add -> add_mode
