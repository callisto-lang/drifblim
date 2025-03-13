#!/bin/sh

as="uxncli bin/drifloon.rom"
asm="uxncli bin/drifblim.rom"

# Usage(missing src)
echo "usage: drifblim.rom in.tal out.rom"
$asm

# Usage(missing dst)
echo "usage: drifblim.rom in.tal out.rom"
$asm examples/hello.tal

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

echo "" && echo "Comment --------------------------------------------"

echo "" && echo "@scope ( BRK @end" | $as > bin/res.tal
echo "Comment open: .. in scope"

echo "" && echo "Writing --------------------------------------------"

echo "" && echo "@scope |80 #1234 @end" | $as > bin/res.tal
echo "Writing in zero-page: #1234 in scope"

echo "" && echo "Symbol ---------------------------------------------"

echo "" && echo "@scope @foo @foo @end" | $as > bin/res.tal
echo "Symbol duplicate: foo"

echo "" && echo "@scope @1234 @end" | $as > bin/res.tal
echo "Symbol invalid: 1234"

echo "" && echo "@scope @LDA @end" | $as > bin/res.tal
echo "Symbol invalid: LDA"

echo "" && echo "%label { SUB } @label" | $as > bin/res.tal
echo "Symbol duplicate: @label"

echo "" && echo "@scope &foo &foo @end" | $as > bin/res.tal
echo "Symbol duplicate: foo in scope"

echo "" && echo "Opcode ---------------------------------------------"

echo "" && echo "@scope ADD2q @end" | $as > bin/res.tal
echo "Opcode invalid: ADD2q in scope"

echo "" && echo "Number ---------------------------------------------"

echo "" && echo "@scope 2 @end" | $as > bin/res.tal
echo "Number invalid: 2 in scope"

echo "" && echo "@scope 123 @end" | $as > bin/res.tal
echo "Number invalid: 123 in scope"

echo "" && echo "@scope 12345 @end" | $as > bin/res.tal
echo "Number invalid: 12345 in scope"

echo "" && echo "@scope #1g @end" | $as > bin/res.tal
echo "Number invalid: #1g in scope"

echo "" && echo "@scope #123g @end" | $as > bin/res.tal
echo "Number invalid: #123g in scope"

echo "" && echo "Macros ---------------------------------------------"

echo "" && echo "%label { ADD } %label { SUB }" | $as > bin/res.tal
echo "Macro duplicate: label"

echo "" && echo "%label #1234" | $as > bin/res.tal
echo "Macro open: label"

echo "" && echo "%scope { BRK @end" | $as > bin/res.tal
echo "Macro invalid: label"

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
echo "Reference too far: back in scope"


