#!/bin/sh

as="uxncli bin/drifloon.rom"
asm="uxncli bin/drifblim.rom"

# Usage(missing src)
echo "usage: drifblim.rom in.tal out.rom"
$asm

# Usage(missing dst)
echo "usage: drifblim.rom in.tal out.rom"
$asm examples/hello.tal

echo "" && echo "@scope" | $as > bin/res.tal
echo "Assembled in 0 bytes."

echo "" && echo "Token ----------------------------------------------"

echo "" && echo "@scope ; @end" | $as > bin/res.tal
echo "Token invalid: ; in scope"

echo "" && echo "@scope . @end" | $as > bin/res.tal
echo "Token invalid: . in scope"

echo "" && echo "@scope , @end" | $as > bin/res.tal
echo "Token invalid: , in scope"

echo "" && echo "@scope LIT2 = @end" | $as > bin/res.tal
echo "Token invalid: = in scope"

echo "" && echo "@scope LIT - @end" | $as > bin/res.tal
echo "Token invalid: - in scope"

echo "" && echo "@scope LIT _ @end" | $as > bin/res.tal
echo "Token invalid: _ in scope"

echo "" && echo "@scope | @end" | $as > bin/res.tal
echo "Token invalid: | in scope"

echo "" && echo "@scope $ @end" | $as > bin/res.tal
echo "Token invalid: $ in scope"

echo "" && echo "@scope \" @end" | $as > bin/res.tal
echo "Token invalid: \" in scope"

echo "" && echo "@scope ! @end" | $as > bin/res.tal
echo "Token invalid: ! in scope"

echo "" && echo "@scope ? @end" | $as > bin/res.tal
echo "Token invalid: ? in scope"

echo "" && echo "@scope # @end" | $as > bin/res.tal
echo "Token invalid: # in scope"

echo "" && echo "@scope AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA @end" | $as > bin/res.tal
echo "Token exceeded: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA in scope"

echo "" && echo "Comment --------------------------------------------"

echo "" && echo "@scope ( BRK @end" | $as > bin/res.tal
echo "Comment open: .. in scope"

echo "" && echo "@scope #01 (BRK ) @end" | $as > bin/res.tal
echo "Comment invalid: (BRK in scope"

echo "" && echo "Writing --------------------------------------------"

echo "" && echo "@scope |80 #1234 @end" | $as > bin/res.tal
echo "Writing in zero-page: #1234 in scope"

echo "" && echo "Symbol ---------------------------------------------"

echo "" && echo "@scope @foo @foo @end" | $as > bin/res.tal
echo "Symbol duplicate: @foo in foo"

echo "" && echo "@scope @1234 @end" | $as > bin/res.tal
echo "Symbol invalid: @1234 in 1234"

echo "" && echo "@scope @LDA @end" | $as > bin/res.tal
echo "Symbol invalid: @LDA in LDA"

echo "" && echo "%label { SUB } @label" | $as > bin/res.tal
echo "Symbol duplicate: @label in label"

echo "" && echo "@scope &foo &foo @end" | $as > bin/res.tal
echo "Symbol duplicate: &foo in scope/foo"

echo "" && echo "@AAAAAAAAAAAAAAAAAAAAAAAAA &BBBBBBBBBBBBBBBBBBBBBBB @end" | $as > bin/res.tal
echo "Symbol exceeded: &BBBBBBBBBBBBBBBBBBBBBBB in AAAAAAAAAAAAAAAAAAAAAAAAA/BBBBBBBBBBBBBBBBBBBB"

echo "" && echo "Opcode ---------------------------------------------"

echo "" && echo "@scope ADD2q @end" | $as > bin/res.tal
echo "Opcode invalid: ADD2q in scope"

echo "" && echo "Number ---------------------------------------------"

echo "" && echo "2" | $as > bin/res.tal
echo "Number invalid: 2 in scope"

echo "" && echo "123" | $as > bin/res.tal
echo "Number invalid: 123 in scope"

echo "" && echo "12345" | $as > bin/res.tal
echo "Number invalid: 12345 in scope"

echo "" && echo "#2" | $as > bin/res.tal
echo "Number invalid: #2 in scope"

echo "" && echo "#123" | $as > bin/res.tal
echo "Number invalid: #123 in scope"

echo "" && echo "#12345" | $as > bin/res.tal
echo "Number invalid: #12345 in scope"

echo "" && echo "@scope #1g" | $as > bin/res.tal
echo "Number invalid: #1g in scope"

echo "" && echo "@scope #123g" | $as > bin/res.tal
echo "Number invalid: #123g in scope"

echo "" && echo "Macros ---------------------------------------------"

echo "" && echo "@scope %label { ADD } %label { SUB }" | $as > bin/res.tal
echo "Macro duplicate: %label in scope"

echo "" && echo "@scope %label #1234" | $as > bin/res.tal
echo "Macro open: .. in scope"

echo "" && echo "@scope %test { BRK @end" | $as > bin/res.tal
echo "Macro open: .. in scope"

echo "" && echo "@scope %macro {BRK } #1234" | $as > bin/res.tal
echo "Macro open: .. in scope"

echo "" && echo "@scope %macro { BRK} #1234" | $as > bin/res.tal
echo "Macro open: .. in scope"

echo "" && echo "References -----------------------------------------"

echo "" && echo "@scope LIT2 =label @end" | $as > bin/res.tal
echo "Reference invalid: label in scope"

echo "" && echo "@scope ;label @end" | $as > bin/res.tal
echo "Reference invalid: label in scope"

echo "" && echo "@scope .label @end" | $as > bin/res.tal
echo "Reference invalid: label in scope"

echo "" && echo "@scope ,label @end" | $as > bin/res.tal
echo "Reference invalid: label in scope"

echo "" && echo "@scope LIT _label @end" | $as > bin/res.tal
echo "Reference invalid: label in scope"

echo "" && echo "@scope ,next \$81 @next @end" | $as > bin/res.tal
echo "Reference too far: next in scope"

echo "" && echo "@back \$7e @scope ,back @end" | $as > bin/res.tal
echo "Reference too far: ,back in scope"
