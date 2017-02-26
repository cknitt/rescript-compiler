(* Copyright (C) 2015-2016 Bloomberg Finance L.P.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)


let check_from_end al =
    let rec aux l seen =
        match l with
        | [] -> false
        | (e::r) ->
            if e < 0 || e > 255 then false
             else (let c = Char.chr e in
             if c = '/' then true
             else (if List.exists (fun x -> x = c) seen then false (* flag should not be repeated *)
             else (if c = 'i' || c = 'g' || c = 'm' || c = 'y' || c ='u' then aux r (c::seen) 
             else false)))
    in aux al []

let js_regex_checker s =
  try
  begin
  if String.length s = 0 then false else
  let al = Ext_utf8.decode_utf8_string s in
  let check_first = (List.hd al) = int_of_char '/' in
  let check_last = check_from_end (List.rev al) in
  check_first && check_last
  end with Invalid_argument err -> false