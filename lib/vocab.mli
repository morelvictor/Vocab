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

val init : unit -> unit
val save_list : vocab_list -> unit
val load_list : string -> vocab_list
val pp_list : Format.formatter -> vocab_list -> unit
val create_list : Format.formatter -> vocab_list
val add_mode : Format.formatter -> vocab_list -> unit
val train_mode : Format.formatter -> vocab_list -> unit
