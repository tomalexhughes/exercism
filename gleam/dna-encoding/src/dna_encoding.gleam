import gleam/bit_array
import gleam/list
import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  dna
  |> list.map(fn(nucleotide) { <<encode_nucleotide(nucleotide):2>> })
  |> bit_array.concat
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  do_decode(dna, []) |> list.reverse |> result.all
}

fn do_decode(
  dna: BitArray,
  decoded_list: List(Result(Nucleotide, Nil)),
) -> List(Result(Nucleotide, Nil)) {
  case dna {
    <<code:2, rest:bits>> ->
      do_decode(rest, [decode_nucleotide(code), ..decoded_list])

    <<>> -> decoded_list
    _ -> [Error(Nil), ..decoded_list]
  }
}
