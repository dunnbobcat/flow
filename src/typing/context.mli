(**
 * Copyright (c) 2013-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the "flow" directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
 *)

type env = Scope.t list

type t
type metadata = {
  checked: bool;
  enable_const_params: bool;
  enable_unsafe_getters_and_setters: bool;
  enforce_strict_type_args: bool;
  esproposal_class_static_fields: Options.esproposal_feature_mode;
  esproposal_class_instance_fields: Options.esproposal_feature_mode;
  esproposal_decorators: Options.esproposal_feature_mode;
  esproposal_export_star_as: Options.esproposal_feature_mode;
  facebook_ignore_fbt: bool;
  ignore_non_literal_requires: bool;
  max_trace_depth: int;
  munge_underscores: bool;
  root: Path.t;
  strip_root: bool;
  suppress_comments: Str.regexp list;
  suppress_types: SSet.t;
  verbose: int option;
  weak: bool;
}
type module_exports_type =
  | CommonJSModule of Loc.t option
  | ESModule

val make: metadata -> Loc.filename -> Modulename.t -> t
val metadata_of_options: Options.t -> metadata

(* accessors *)
val all_unresolved: t -> Type.TypeSet.t IMap.t
val annot_table: t -> (Loc.t, Type.t) Hashtbl.t
val enable_const_params: t -> bool
val enable_unsafe_getters_and_setters: t -> bool
val enforce_strict_type_args: t -> bool
val envs: t -> env IMap.t
val errors: t -> Errors_js.ErrorSet.t
val error_suppressions: t -> Errors_js.ErrorSuppressions.t
val esproposal_class_static_fields: t -> Options.esproposal_feature_mode
val esproposal_class_instance_fields: t -> Options.esproposal_feature_mode
val esproposal_decorators: t -> Options.esproposal_feature_mode
val esproposal_export_star_as: t -> Options.esproposal_feature_mode
val evaluated: t -> Type.t IMap.t
val file: t -> Loc.filename
val find_props: t -> Constraint_js.ident -> Type.properties
val find_module: t -> string -> Type.t
val globals: t -> SSet.t
val graph: t -> Constraint_js.node IMap.t
val in_declare_module: t -> bool
val is_checked: t -> bool
val is_verbose: t -> bool
val is_weak: t -> bool
val max_trace_depth: t -> int
val module_exports_type: t -> module_exports_type
val module_map: t -> Type.t SMap.t
val module_name: t -> Modulename.t
val property_maps: t -> Type.properties IMap.t
val required: t -> SSet.t
val require_loc: t -> Loc.t SMap.t
val root: t -> Path.t
val should_ignore_fbt: t -> bool
val should_ignore_non_literal_requires: t -> bool
val should_munge_underscores: t -> bool
val should_strip_root: t -> bool
val suppress_comments: t -> Str.regexp list
val suppress_types: t -> SSet.t
val type_graph: t -> Graph_explorer.graph
val type_table: t -> (Loc.t, Type.t) Hashtbl.t
val verbose: t -> int option

val copy_of_context: t -> t
val merge_into: t -> t -> unit

(* mutators *)
val add_env: t -> int -> env -> unit
val add_error: t -> Errors_js.error -> unit
val add_error_suppression: t -> Loc.t -> unit
val add_global: t -> string -> unit
val add_module: t -> string -> Type.t -> unit
val add_property_map: t -> Constraint_js.ident -> Type.properties -> unit
val add_require: t -> string -> Loc.t -> unit
val add_tvar: t -> Constraint_js.ident -> Constraint_js.node -> unit
val remove_all_errors: t -> unit
val remove_all_error_suppressions: t -> unit
val remove_tvar: t -> Constraint_js.ident -> unit
val set_envs: t -> env IMap.t -> unit
val set_evaluated: t  -> Type.t IMap.t -> unit
val set_type_graph: t  -> Graph_explorer.graph -> unit
val set_all_unresolved: t  -> Type.TypeSet.t IMap.t -> unit
val set_globals: t -> SSet.t -> unit
val set_graph: t -> Constraint_js.node IMap.t -> unit
val set_in_declare_module: t -> bool -> unit
val set_module_exports_type: t -> module_exports_type -> unit
val set_property_maps: t -> Type.properties IMap.t -> unit
val set_tvar: t -> Constraint_js.ident -> Constraint_js.node -> unit

(* constructors *)
val make_property_map: t -> Type.properties -> Constraint_js.ident
