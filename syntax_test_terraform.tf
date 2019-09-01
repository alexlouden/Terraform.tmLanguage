# SYNTAX TEST "Terraform.sublime-syntax"

/////////////////////////////////////////////////////////////////////
// INLINE COMMENTS
/////////////////////////////////////////////////////////////////////

/////
// Start of line inline comments with `#`.
/////

# inline comment
# ^ source.terraform comment.line.terraform

/////
// Start of line inline comments with `//`.
/////

// foo
# ^ source.terraform comment.line.terraform

/////
// Matches at random place in line + punctuation for `#`.
/////

        # bar
#     ^ -comment -punctuation
#       ^ punctuation.definition.comment.terraform
#       ^^^^^ comment.line.terraform

/////
// Matches at random place in line + punctuation for `//`.
/////

    // baz # blah
# ^ -comment -punctuation
#   ^^ punctuation.definition.comment.terraform
#   ^^^^^^^^^^^^^ comment.line.terraform

/////////////////////////////////////////////////////////////////////
// BLOCK COMMENTS
/////////////////////////////////////////////////////////////////////

/////
// Matches for a single line.
/////

    /* foo */
# ^ -comment -punctuation
#   ^^ punctuation.definition.comment.terraform
#   ^^^^^^^^ comment.block.terraform
#          ^^ punctuation.definition.comment.terraform

/////
// Matches over multiple lines.
/////

    /*
# ^ -comment -punctuation
#   ^^ punctuation.definition.comment.terraform
#   ^^^^ comment.block.terraform

  foo
# ^^^^ comment.block.terraform

    */
# ^^^^ comment.block.terraform
#   ^^ punctuation.definition.comment.terraform

/////
// Matches inline comments after block ends.
/////

     /* comment */    // inline
# ^ -comment -punctuation
#    ^^ punctuation.definition.comment.terraform
#    ^^^^^^^^^^^^ comment.block.terraform
#               ^^ punctuation.definition.comment.terraform
#                 ^^^ -comment -punctuation
#                     ^^ punctuation.definition.comment.terraform
#                     ^^^^^^^^ comment.line.terraform

/////////////////////////////////////////////////////////////////////
// LANGUAGE CONSTANTS
/////////////////////////////////////////////////////////////////////

/////
// Matches `true`.
/////

    true
# ^ -constant
#   ^^^^ constant.language.terraform
#         ^ -constant

/////
// Matches `false`.
/////

    false
# ^ -constant
#   ^^^^^ constant.language.terraform
#         ^ -constant


/////
// Matches `null`.
/////

    null
# ^ -constant
#   ^^^^ constant.language.terraform
#         ^ -constant


/////////////////////////////////////////////////////////////////////
// INTEGER CONSTANTS
/////////////////////////////////////////////////////////////////////

/////
// Matches integers.
/////

    444
# ^ -constant -numeric
#   ^^^ constant.numeric.integer.terraform

/////
// Matches zero.
/////

      0
# ^ -constant -numeric
#     ^ constant.numeric.integer.terraform

/////
// Matches one.
/////

      1
# ^ -constant -numeric
#     ^ constant.numeric.integer.terraform

/////
// Matches large integers.
/////

      26345645634561
# ^ -constant -numeric
#     ^^^^^^^^^^^^^^ constant.numeric.integer.terraform

/////////////////////////////////////////////////////////////////////
// FLOATING-POINT CONSTANTS
/////////////////////////////////////////////////////////////////////

/////
// Matches floating-point numbers.
/////

      1.2
# ^ -constant -numeric
#     ^ constant.numeric.float.terraform
#      ^ punctuation.separator.decimal.terraform
#       ^ constant.numeric.float.terraform

/////
// Matches large floating-point numbers.
/////

      61.28888888888
#   ^ -constant -numeric
#     ^^ constant.numeric.float.terraform
#       ^ punctuation.separator.decimal.terraform
#        ^^^^^^^^^^^ constant.numeric.float.terraform

/////
// Matches integers with exponents.
/////

      1e12
#   ^ -constant -numeric
#     ^ constant.numeric.float.terraform
#      ^ punctuation.separator.exponent.terraform
#       ^^ constant.numeric.float.terraform

/////
// Matches floats with exponents.
/////

      1.4E12
#   ^ -constant -numeric
#     ^ constant.numeric.float.terraform
#      ^ punctuation.separator.decimal.terraform
#       ^ constant.numeric.float.terraform
#        ^ punctuation.separator.exponent.terraform
#         ^^ constant.numeric.float.terraform

/////
// Matches floats with postive signed exponents.
/////

      1.4e+12
#   ^ -constant -numeric
#     ^ constant.numeric.float.terraform
#      ^ punctuation.separator.decimal.terraform
#       ^ constant.numeric.float.terraform
#        ^^ punctuation.separator.exponent.terraform
#          ^^ constant.numeric.float.terraform

/////
// Matches floats with negative signed exponents.
/////

      1.4E-12
#   ^ -constant -numeric
#     ^ constant.numeric.float.terraform
#      ^ punctuation.separator.decimal.terraform
#       ^ constant.numeric.float.terraform
#        ^^ punctuation.separator.exponent.terraform
#          ^^ constant.numeric.float.terraform

/////////////////////////////////////////////////////////////////////
// STRINGS
/////////////////////////////////////////////////////////////////////

/////
// Matches punctuation and assigns meta_scope.
/////

      "a string"
#   ^ -punctuation -string
#     ^ punctuation.definition.string.begin.terraform
#     ^^^^^^^^^^ string.quoted.double.terraform
#              ^ punctuation.definition.string.end.terraform
#                 ^ -punctuation -string

/////
// Matches character escapes.
/////

      "a \n b \r c \t d \" e \udead f \udeadbeef"
#   ^ -punctuation -string
#     ^ punctuation.definition.string.begin.terraform
#     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ string.quoted.double.terraform
#        ^^ constant.character.escape.terraform
#             ^^ constant.character.escape.terraform
#                  ^^ constant.character.escape.terraform
#                       ^^ constant.character.escape.terraform
#                            ^^^^^ constant.character.escape.terraform
#                                     ^^^^^^^^^^ constant.character.escape.terraform
#                                               ^ punctuation.definition.string.end.terraform

/////////////////////////////////////////////////////////////////////
// STRING INTERPOLATION
/////////////////////////////////////////////////////////////////////

/////
// Correct scopes during interpolation.
/////

      "some ${interpolation} string"
#   ^ -punctuation -string
#     ^ punctuation.definition.string.begin.terraform
#      ^^^^^ string.quoted.double.terraform
#           ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#             ^^^^^^^^^^^^^^ meta.interpolation.terraform
#                          ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                            ^^^^^^^ string.quoted.double.terraform
#                                  ^ punctuation.definition.string.end.terraform
#                                   ^ -punctuation -string

/////
// Matches left-trim and right-trim.
/////

      "%{~ fff ~}"
#     ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#      ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#        ^^ meta.interpolation.terraform keyword.operator.template.left.trim.terraform
#          ^^^^^^ meta.interpolation.terraform
#             ^^ meta.interpolation.terraform keyword.operator.template.right.trim.terraform
#               ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                ^ string.quoted.double.terraform punctuation.definition.string.end.terraform

/////
// Matches operators
/////

    "${ something ? true : false }"
#   ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#    ^^ punctuation.section.interpolation.begin.terraform
#     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform
#                 ^ keyword.operator.terraform
#                   ^^^^ meta.interpolation.terraform constant.language.terraform
#                        ^ meta.interpolation.terraform keyword.operator.terraform
#                          ^^^^^ meta.interpolation.terraform constant.language.terraform
#                                ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                 ^ string.quoted.double.terraform punctuation.definition.string.end.terraform

/////
// Dot-access attributes in string interpolation
/////

    "hello ${aws_instance.ubuntu}"
#   ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#   ^^^^^^^ string.quoted.double.terraform
#          ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#            ^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform
#                        ^ meta.interpolation.terraform punctuation.accessor.dot.terraform
#                         ^^^^^^ meta.interpolation.terraform variable.other.member.terraform
#                               ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                ^ string.quoted.double.terraform punctuation.definition.string.end.terraform

/////////////////////////////////////////////////////////////////////
// Template If Directives
/////////////////////////////////////////////////////////////////////

/////
// Matches if/endif directives.
/////

      "${ if name == "Mary" }${name}${ endif ~}"
#    ^ -string -punctuation
#     ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#      ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform
#         ^^ meta.interpolation.terraform keyword.control.terraform
#                    ^ source.terraform meta.interpolation.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                    ^^^^^^ source.terraform meta.interpolation.terraform string.quoted.double.terraform
#                         ^ source.terraform meta.interpolation.terraform string.quoted.double.terraform punctuation.definition.string.end.terraform
#                           ^ punctuation.section.interpolation.end.terraform
#                            ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                  ^ punctuation.section.interpolation.end.terraform 
#                                   ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                      ^^^^^ meta.interpolation.terraform keyword.control.terraform
#                                            ^ meta.interpolation.terraform keyword.operator.template.right.trim.terraform
#                                             ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                              ^ string.quoted.double.terraform punctuation.definition.string.end.terraform
#                                               ^ -string -punctuation

/////
// Matches if/else/endif directives.
/////

      "%{ if name == "Mary" }${name}%{ else }${ "Mary" }%{ endif ~}"
#    ^ -string -punctuation
#     ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#      ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform
#         ^^ meta.interpolation.terraform keyword.control.terraform
#                    ^ source.terraform meta.interpolation.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                    ^^^^^^ source.terraform meta.interpolation.terraform string.quoted.double.terraform
#                         ^ source.terraform meta.interpolation.terraform string.quoted.double.terraform punctuation.definition.string.end.terraform
#                           ^ punctuation.section.interpolation.end.terraform
#                            ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                  ^ punctuation.section.interpolation.end.terraform 
#                                   ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                      ^^^^ meta.interpolation.terraform keyword.control.terraform
#                                           ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                            ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                               ^ meta.interpolation.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                                ^^^^^ meta.interpolation.terraform string.quoted.double.terraform
#                                                      ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                                      ^ punctuation.section.interpolation.end.terraform
#                                                       ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                                          ^^^^^ meta.interpolation.terraform keyword.control.terraform
#                                                                ^ meta.interpolation.terraform keyword.operator.template.right.trim.terraform
#                                                                 ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                                                  ^ string.quoted.double.terraform punctuation.definition.string.end.terraform
#                                                                   ^ -string -punctuation

/////
// Matches for/in/endfor directives.
// TODO: add checks for var.*
/////

      "%{ for name in var.names ~}${name}%{ endfor ~}"
#   ^ -string -punctuation      
#     ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#      ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#         ^^^ keyword.control.terraform
#      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform
#                  ^^ keyword.control.terraform
#                        ^ meta.interpolation.terraform punctuation.accessor.dot.terraform
#                         ^^^^^ meta.interpolation.terraform variable.other.member.terraform
#                               ^ keyword.operator.template.right.trim.terraform
#                                ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                 ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                       ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                        ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#                                           ^^^^^^ meta.interpolation.terraform keyword.control.terraform
#                                                  ^ meta.interpolation.terraform keyword.operator.template.right.trim.terraform
#                                                   ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                                    ^ string.quoted.double.terraform punctuation.definition.string.end.terraform
#                                                     ^ -string -punctuation

/////
// Handles function calls
/////

      "${formatdate("DD MMM YYYY hh:mm ZZZ", "2018-01-02T23:12:01Z")}"
#     ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#      ^^ meta.interpolation.terraform punctuation.section.interpolation.begin.terraform
#        ^^^^^^^^^^ meta.interpolation.terraform meta.function-call.terraform variable.function.terraform
#                  ^ meta.interpolation.terraform meta.function-call.terraform punctuation.section.parens.begin.terraform
#                   ^ meta.interpolation.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                    ^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform meta.function-call.terraform string.quoted.double.terraform
#                                          ^ meta.interpolation.terraform meta.function-call.terraform punctuation.separator.terraform
#                                            ^ meta.interpolation.terraform meta.function-call.terraform string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                                             ^^^^^^^^^^^^^^^^^^^^^ meta.interpolation.terraform meta.function-call.terraform string.quoted.double.terraform
#                                                                  ^ meta.interpolation.terraform meta.function-call.terraform punctuation.section.parens.end.terraform
#                                                                   ^ meta.interpolation.terraform punctuation.section.interpolation.end.terraform
#                                                                    ^ string.quoted.double.terraform punctuation.definition.string.end.terraform

/////////////////////////////////////////////////////////////////////
// Operators
/////////////////////////////////////////////////////////////////////

/////
// Comparison
/////

    a == b
#   ^ -keyword -operator
#     ^^ keyword.operator.terraform
#         ^ -keyword -operator 

    a != b
#   ^ -keyword -operator
#     ^^ keyword.operator.terraform
#         ^ -keyword -operator 

    a < b
#    ^ -keyword -operator
#     ^ keyword.operator.terraform
#      ^ -keyword -operator

    a <= b
#    ^ -keyword -operator
#     ^^ keyword.operator.terraform
#       ^ -keyword -operator

    a > b
#    ^ -keyword -operator 
#     ^ keyword.operator.terraform
#      ^ -keyword -operator

    a >= b
#    ^ -keyword -operator
#     ^^ keyword.operator.terraform
#       ^ -keyword -operator

/////
// Arithmetic
/////

    a + b
#    ^ -keyword -operator
#     ^ keyword.operator.arithmetic.terraform
#      ^ -keyword -operator

    a - b
#    ^ -keyword -operator
#     ^ keyword.operator.arithmetic.terraform
#      ^ -keyword -operator

    a * b
#    ^ -keyword -operator
#     ^ keyword.operator.arithmetic.terraform
#      ^ -keyword -operator

    a / b
#    ^ -keyword -operator
#     ^ keyword.operator.arithmetic.terraform
#      ^ -keyword -operator

    a % b
#    ^ -keyword -operator
#     ^ keyword.operator.arithmetic.terraform
#      ^ -keyword -operator

    -a
#  ^ -keyword -operator
#   ^ keyword.operator.arithmetic.terraform 
#    ^ -keyword -operator 

/////
// Logic
/////

    a && b
#   ^^ -keyword -operator
#     ^^ keyword.operator.logical.terraform
#       ^^ -keyword -operator

    a || b
#   ^^ -keyword -operator
#     ^^ keyword.operator.logical.terraform
#       ^^ -keyword -operator

    !a
# ^^ -keyword -operator
#   ^ keyword.operator.logical.terraform
#    ^^ -keyword -operator

/////
// Conditional
/////

    length(some_list) > 0 ? some_list[0] : default
#   ^^^^^^ meta.function-call.terraform variable.function.terraform
#         ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#          ^^^^^^^^^ meta.function-call.terraform variable.parameter.terraform
#                   ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                     ^ keyword.operator.terraform
#                       ^ constant.numeric.integer.terraform
#                         ^ keyword.operator.terraform
#                                    ^ punctuation.section.brackets.begin.terraform
#                                     ^ constant.numeric.integer.terraform
#                                      ^ punctuation.section.brackets.end.terraform
#                                        ^ keyword.operator.terraform

/////
// Ellipsis
/////

    min([55, 2453, 2]...)
#   ^^^ meta.function-call.terraform variable.function.terraform
#      ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#       ^ punctuation.section.brackets.begin.terraform
#        ^^ constant.numeric.integer.terraform
#          ^ punctuation.separator.terraform
#            ^^^^ constant.numeric.integer.terraform
#                ^ punctuation.separator.terraform
#                  ^ constant.numeric.integer.terraform
#                   ^ punctuation.section.brackets.end.terraform
#                    ^^^ keyword.operator.terraform 
#                       ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////////////////////////////////////////////////////////////////////
// Brackets: Index Operations and Arrays
// TODO: add for-expressions
// TODO: add arrays of arrays
/////////////////////////////////////////////////////////////////////

/////
// Index Operations
/////

    thing[1]
#       ^ -punctuation 
#        ^ punctuation.section.brackets.begin.terraform
#         ^ constant.numeric.integer.terraform
#          ^ punctuation.section.brackets.end.terraform
#           ^ -punctuation

/////
// Arrays of literals
/////

    ["a", "b", "c"]
#   ^ punctuation.section.brackets.begin.terraform
#    ^ punctuation.definition.string.begin.terraform
#    ^^^ string.quoted.double.terraform
#      ^ punctuation.definition.string.end.terraform
#       ^ punctuation.separator.terraform
#         ^ punctuation.definition.string.begin.terraform
#         ^^^ string.quoted.double.terraform
#           ^ punctuation.definition.string.end.terraform
#            ^ punctuation.separator.terraform
#              ^ punctuation.definition.string.begin.terraform
#              ^^^ string.quoted.double.terraform
#                ^ punctuation.definition.string.end.terraform
#                 ^ punctuation.section.brackets.end.terraform

/////
// Allows inline comments
/////

    [1, /* inline */ 2]
#   ^ punctuation.section.brackets.begin.terraform
#    ^ constant.numeric.integer.terraform
#     ^ punctuation.separator.terraform
#       ^^ punctuation.definition.comment.terraform
#       ^^^^^^^^^^^^ comment.block.terraform
#                 ^^ punctuation.definition.comment.terraform
#                    ^ constant.numeric.integer.terraform
#                     ^ punctuation.section.brackets.end.terraform

/////
// Allows expression over multiple lines
/////

    [
#   ^ punctuation.section.brackets.begin.terraform
      1,
#     ^ constant.numeric.integer.terraform
#      ^ punctuation.separator.terraform
      2
#     ^ constant.numeric.integer.terraform
    ]
#   ^ punctuation.section.brackets.end.terraform

/////
// Allows operators
/////

    [ 1 + 2 ]
#   ^ punctuation.section.brackets.begin.terraform
#     ^ constant.numeric.integer.terraform
#       ^ keyword.operator.arithmetic.terraform
#         ^ constant.numeric.integer.terraform
#           ^ punctuation.section.brackets.end.terraform

/////
// Splat operator
/////

    tuple[*].foo.bar[0]
#        ^ punctuation.section.brackets.begin.terraform
#         ^ punctuation.section.brackets.end.terraform keyword.operator.splat.terraform
#          ^ punctuation.section.brackets.end.terraform
#           ^ punctuation.accessor.dot.terraform
#            ^^^ variable.other.member.terraform
#               ^ punctuation.accessor.dot.terraform
#                ^^^ variable.other.member.terraform
#                   ^ punctuation.section.brackets.begin.terraform
#                    ^ constant.numeric.integer.terraform
#                     ^ punctuation.section.brackets.end.terraform

/////////////////////////////////////////////////////////////////////
// Attribute Access
/////////////////////////////////////////////////////////////////////

/////
// Matches dot-access
/////

    aws_instance.ubuntu[*].private_dns
#               ^ punctuation.accessor.dot.terraform
#                ^^^^^^ variable.other.member.terraform
#                      ^ punctuation.section.brackets.begin.terraform
#                       ^ punctuation.section.brackets.end.terraform keyword.operator.splat.terraform
#                        ^ punctuation.section.brackets.end.terraform
#                         ^ punctuation.accessor.dot.terraform
#                          ^^^^^^^^^^^ variable.other.member.terraform
#                                     ^ -variable -punctuation 

/////
// Ignores dot-access in string literals
/////

    "aws_instance.ubuntu"
#   ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#                ^ -variable
#   ^^^^^^^^^^^^^^^^^^^^^ string.quoted.double.terraform

/////
// Matches inside for-expressions
// TODO: add for-expression match
/////

    for l in var.letters: upper(l)
#               ^ punctuation.accessor.dot.terraform
#                ^^^^^^^ variable.other.member.terraform
#                       ^ keyword.operator.terraform 
#                         ^^^^^ meta.function-call.terraform variable.function.terraform
#                              ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                               ^ meta.function-call.terraform variable.parameter.terraform
#                                ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Attribute-only splat
/////

    tuple.*.foo.bar[0]
#        ^ punctuation.accessor.dot.terraform
#         ^ keyword.operator.splat.terraform
#          ^ punctuation.accessor.dot.terraform
#           ^^^ variable.other.member.terraform
#              ^ punctuation.accessor.dot.terraform
#               ^^^ variable.other.member.terraform
#                  ^ punctuation.section.brackets.begin.terraform
#                   ^ constant.numeric.integer.terraform
#                    ^ punctuation.section.brackets.end.terraform

/////////////////////////////////////////////////////////////////////
// Attribute Definition
/////////////////////////////////////////////////////////////////////

/////
// Basic definition
// TODO: match var keyword
/////

    count = length(var.availability_zones)
#   ^^^^^ variable.declaration.terraform variable.other.readwrite.terraform
#         ^ variable.declaration.terraform keyword.operator.assignment.terraform
#           ^^^^^^ meta.function-call.terraform variable.function.terraform
#                 ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#                  ^^^ meta.function-call.terraform variable.parameter.terraform
#                     ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                      ^^^^^^^^^^^^^^^^^^ meta.function-call.terraform variable.other.member.terraform
#                                        ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Populate an attribute from a variable value
/////

    (foo) = "baz"
#   ^ variable.declaration.terraform punctuation.section.parens.begin.terraform
#    ^^^ variable.declaration.terraform variable.other.readwrite.terraform
#       ^ variable.declaration.terraform punctuation.section.parens.end.terraform
#         ^ variable.declaration.terraform keyword.operator.assignment.terraform
#           ^ string.quoted.double.terraform punctuation.definition.string.begin.terraform
#           ^^^^^ string.quoted.double.terraform
#               ^ string.quoted.double.terraform punctuation.definition.string.end.terraform 

/////////////////////////////////////////////////////////////////////
// Function Calls
// TODO: object literals as parameters
/////////////////////////////////////////////////////////////////////


/////
// Basic call
/////

    upper(l)
#   ^^^^^ meta.function-call.terraform variable.function.terraform
#        ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#         ^ meta.function-call.terraform variable.parameter.terraform
#          ^ meta.function-call.terraform punctuation.section.parens.end.terraform

/////
// Matches parameters, attribute-access, literals, operators, commas
/////

    cidrsubnet(aws_vpc.main.cidr_block, 4, count.index+1)
#   ^^^^^^^^^^ meta.function-call.terraform variable.function.terraform
#             ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#              ^^^^^^^ meta.function-call.terraform variable.parameter.terraform
#                     ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                      ^^^^ meta.function-call.terraform variable.other.member.terraform
#                          ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                           ^^^^^^^^^^ meta.function-call.terraform variable.other.member.terraform
#                                     ^ meta.function-call.terraform punctuation.separator.terraform
#                                       ^ meta.function-call.terraform constant.numeric.integer.terraform
#                                        ^ meta.function-call.terraform punctuation.separator.terraform
#                                          ^^^^^ meta.function-call.terraform variable.parameter.terraform
#                                               ^ meta.function-call.terraform punctuation.accessor.dot.terraform
#                                                ^^^^^ meta.function-call.terraform variable.other.member.terraform
#                                                     ^ meta.function-call.terraform keyword.operator.arithmetic.terraform
#                                                      ^ meta.function-call.terraform constant.numeric.integer.terraform
#                                                       ^ meta.function-call.terraform punctuation.section.parens.end.terraform
#                                                        ^ -meta -function-call -variable

/////
// Matches arrays and splat
/////

      max([55, 2453, 2]..., [55555555])
#     ^^^ meta.function-call.terraform variable.function.terraform
#        ^ meta.function-call.terraform punctuation.section.parens.begin.terraform
#         ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#          ^^ meta.function-call.terraform constant.numeric.integer.terraform
#            ^ meta.function-call.terraform punctuation.separator.terraform
#              ^^^^ meta.function-call.terraform constant.numeric.integer.terraform
#                  ^ meta.function-call.terraform punctuation.separator.terraform
#                    ^ meta.function-call.terraform constant.numeric.integer.terraform
#                     ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                      ^^^ meta.function-call.terraform keyword.operator.terraform
#                         ^ meta.function-call.terraform punctuation.separator.terraform
#                           ^ meta.function-call.terraform punctuation.section.brackets.begin.terraform
#                            ^^^^^^^^ meta.function-call.terraform constant.numeric.integer.terraform
#                                    ^ meta.function-call.terraform punctuation.section.brackets.end.terraform
#                                     ^ meta.function-call.terraform punctuation.section.parens.end.terraform
