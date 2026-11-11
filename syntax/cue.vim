" Copyright 2014 Google Inc. All rights reserved.
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.

if exists("b:current_syntax")
    finish
endif

" add . to keywords so that we can more easily match the go-style func names
syntax iskeyword @,48-57,192-255,.

syntax match cueNumber "\<\d*\([Ee][+-]\?\d\+\)\?\>"
syntax match cueNumber "\<\d\+[.]\d*\([Ee][+-]\?\d\+\)\?\>"
syntax match cueNumber "\<[.]\d\+\([Ee][+-]\?\d\+\)\?\>"
hi def link cueNumber Number


"syn match cueKeyword "[a-zA-Z_$][a-z0-9A-Z_"()\\ ]*\s*[?!]\?::\?"
" syn match cueKeyword2 "\<_[a-zA-Z0-9_]*"
" I think this better matches the actual grammar -- michael, 2026-11-10
syn match cueKeyword "[_#]\?[a-zA-Z_$][a-z0-9A-Z_$]*"
hi def link cueKeyword Keyword

syn region Object start="{" end="}" fold transparent

syntax keyword cueInclude import
syntax keyword cueStatement for in len if let and or div mod quo rem close
syntax match cueStatement "+\|-\|/\|\*\|&&\?\|||\|==\|!=\|=\~\|!\~\|!\|<=\?\|>=\?\|:\|=\|<-\|;\|@\|##"
syntax keyword cueSpecial package command task
syntax keyword cueConstant true false null
syntax keyword cueError error

hi def link cueInclude cueSpecial
hi def link cueSpecial Special
hi def link cueStatement Statement
hi def link cueConstant Constant
hi def link cueError Error

" NOTE(jjo): block comments removed as of cue 0.11
"syn region Comment start="/[*]" end="[*]/"
syn region cueComment start="//" end="$"
syn match cueComment "//.*$"
hi def link cueComment Comment

syn match cueType "<[^>]*>\||"
syn match cueType "\<\(null\|bool\|double\|float\(32\|64\)\?\|s\?u\?int\(8\|16\|32\|64\|128\)\?\|string\|number\|bytes\|\.\.\.\|[*]\)\>"
hi def link cueType Type

" String literals.
syn region cueString start=+\z(#*\)\z('\|"\)+ skip="\\\z2" end="\z2\z1"
" Multiline string literals.
syn region cueString start=+\z(#*\)\z('''\|"""\)+ end="\z2\z1"

hi def link cueString String

" Interpolation
" TODO: handle modified escape delimeters.
syn region cueInterpolation start="\\(" end=")"
syn match cueInterpolation "\\\(([^)]\+)\)" contained containedin=cueString
hi def link cueInterpolation Special


" builtins
" From https://godoc.org/cuelang.org/go/pkg
syn keyword cueBuiltinFunc base64.Decode base64.DecodeddLen base64.Encode base64.EncodeddLen
syn keyword cueBuiltinFunc bits.And bits.At bits.Clear bits.Len bits.Lsh bits.OnesCount bits.Or bits.Rsh bits.Set bits.Xor
syn keyword cueBuiltinFunc cli.Print
syn keyword cueBuiltinFunc csv.Decode csv.Encode
syn keyword cueBuiltinFunc exec.Run
syn keyword cueBuiltinFunc file.Append file.Create file.Glob file.Mkdir file.MkdirAll file.MkdirTemp file.Read file.RemoveAll file.Symlink
syn keyword cueBuiltinFunc hex.Decode hex.DecodeddLen hex.Dump hex.Encode hex.EncodeddLen
syn keyword cueBuiltinFunc hmac.MD5 hmac.SHA1 hmac.SHA224 hmac.SHA256 hmac.SHA384 hmac.SHA512 hmac.SHA512_224 hmac.SHA512_256 hmac.Sign
syn keyword cueBuiltinFunc html.Escape html.Unescape
syn keyword cueBuiltinFunc http.Delete http.Get http.Post http.Put http.Serve
syn keyword cueBuiltinFunc json.Compact json.HTMLEscape json.Indent json.Marshal json.MarshalStream json.Unmarshal json.Valid json.Validate
syn keyword cueBuiltinFunc list.Avg list.Concat list.Contains list.Drop list.FlattenN list.IsSorted list.IsSortedStrings list.Max list.MaxItems list.Min list.MinItems list.Product list.Range list.Repeat list.Slice list.Sort list.SortStable list.SortStrings list.Sum list.Take list.UniqueItems
syn keyword cueBuiltinFunc math.Above math.Abs math.Acos math.Acosh math.Asin math.Asinh math.Atan math.Atan2 math.Atanh math.AwayFromZero math.Below math.Cbrt math.Ceil math.Copysign math.Cos math.Cosh math.Dim math.E math.Erf math.Erfc math.Erfcinv math.Erfinv math.Exact math.Exp math.Exp2 math.Expm1 math.Floor math.Gamma math.Hypot math.Ilogb math.J0 math.J1 math.Jacobi math.Jn math.Ldexp math.Ln10 math.Ln2 math.Log math.Log10 math.Log10E math.Log1p math.Log2 math.Log2E math.Logb math.MaxBase math.MaxExp math.MaxPrec math.MinExp math.Mod math.MultipleOf math.Phi math.Pi math.Pow math.Pow10 math.Remainder math.Round math.RoundToEven math.Signbit math.Sin math.Sinh math.Sqrt math.Sqrt2 math.SqrtE math.SqrtPhi math.SqrtPi math.Tan math.Tanh math.ToNearestAway math.ToNearestEven math.ToNegativeInf math.ToPositiveInf math.ToZero math.Trunc math.Y0 math.Y1 math.Yn
syn keyword cueBuiltinFunc md5.BlockSize md5.Size md5.Sum
syn keyword cueBuiltinFunc net.FQDN net.GlobalUnicastIP net.InterfaceLocalMulticastIP net.IP net.IPString net.IPv4 net.IPv4len net.IPv6len net.JoinHostPort net.LinkLocalMulticastIP net.LinkLocalUnicastIP net.LoopbackIP net.MulticastIP net.ParseIP net.SplitHostPort net.ToIP16 net.ToIP4 net.UnspecifiedIP
syn keyword cueBuiltinFunc path.Base path.Clean path.Dir path.Ext path.FromSlash path.IsAbs path.Join path.Match path.Rel path.Resolve path.Split path.SplitList path.ToSlash path.VolumeName
syn keyword cueBuiltinFunc regexp.Find regexp.FindAll regexp.FindAllNamedSubmatch regexp.FindAllSubmatch regexp.FindNamedSubmatch regexp.FindSubmatch regexp.Match regexp.QuoteMeta regexp.Valid
syn keyword cueBuiltinFunc sha1.BlockSize sha1.Size sha1.Sum
syn keyword cueBuiltinFunc sha256.BlockSize sha256.Size sha256.Size224 sha256.Sum224 sha256.Sum256
syn keyword cueBuiltinFunc sha512.BlockSize sha512.Size sha512.Size224 sha512.Size256 sha512.Size384 sha512.Sum384 sha512.Sum512 sha512.Sum512_224 sha512.Sum512_256
syn keyword cueBuiltinFunc strconv.Atoi strconv.FormatBool strconv.FormatFloat strconv.FormatInt strconv.FormatUint strconv.IntSize strconv.IsGraphic strconv.IsPrint strconv.ParseBool strconv.ParseFloat strconv.ParseInt strconv.ParseUint strconv.Quote strconv.QuoteRune strconv.QuoteRuneToASCII strconv.QuoteRuneToGraphic strconv.QuoteToASCII strconv.QuoteToGraphic strconv.Unquote
syn keyword cueBuiltinFunc strings.ByteAt strings.ByteSlice strings.Compare strings.Contains strings.ContainsAny strings.Count strings.Fields strings.HasPrefix strings.HasSuffix strings.Index strings.IndexAny strings.Join strings.LastIndex strings.LastIndexAny strings.MaxRunes strings.MinRunes strings.Repeat strings.Replace strings.Runes strings.SliceRunes strings.Split strings.SplitAfter strings.SplitAfterN strings.SplitN strings.ToCamel strings.ToLower strings.ToTitle strings.ToUpper strings.Trim strings.TrimLeft strings.TrimPrefix strings.TrimRight strings.TrimSpace strings.TrimSuffix
syn keyword cueBuiltinFunc struct.MaxFields struct.MinFields
syn keyword cueBuiltinFunc tabwriter.Write template.Execute
syn keyword cueBuiltinFunc template.HTMLEscape template.JSEscape
syn keyword cueBuiltinFunc time.ANSIC time.April time.August time.December time.Duration time.February time.Format time.Friday time.Hour time.January time.July time.June time.Kitchen time.Kitchen24 time.March time.May time.Microsecond time.Millisecond time.Minute time.Monday time.Nanosecond time.November time.October time.Parse time.ParseDuration time.RFC1123 time.RFC1123Z time.RFC3339 time.RFC3339Date time.RFC3339Nano time.RFC822 time.RFC822Z time.RFC850 time.RubyDate time.Saturday time.Second time.September time.Sunday time.Thursday time.Time time.Tuesday time.Unix time.UnixDate time.Wednesday
syn keyword cueBuiltinFunc uuid.FromInt uuid.MD5 uuid.Parse uuid.SHA1 uuid.ToInt uuid.ToString uuid.URN uuid.Valid uuid.Variant uuid.Version
syn keyword cueBuiltinFunc yaml.Marshal yaml.MarshalStream yaml.Unmarshal yaml.Validate yaml.ValidatePartial

hi def link cueBuiltinFunc Constant

let b:current_syntax = "cue"
