
return strings::Substitute("$0/$1_$2.dat", dir, rowset_id.to_string(), segment_id);


```
void SubstituteAndAppend(
  string* output, StringPiece format,
  const internal::SubstituteArg& arg0 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg1 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg2 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg3 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg4 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg5 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg6 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg7 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg8 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg9 = internal::SubstituteArg::NoArg);

inline string Substitute(
  StringPiece format,
  const internal::SubstituteArg& arg0 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg1 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg2 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg3 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg4 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg5 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg6 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg7 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg8 = internal::SubstituteArg::NoArg,
  const internal::SubstituteArg& arg9 = internal::SubstituteArg::NoArg) {
  string result;
  SubstituteAndAppend(&result, format, arg0, arg1, arg2, arg3, arg4,
                                       arg5, arg6, arg7, arg8, arg9);
  return result;
}
```
