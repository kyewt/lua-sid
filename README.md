# About
<p>Generates a new sequential ID by modifying the last generated ID starting at an id composed of only the first character in the given character set.

The amount of IDs that can be generated is determined by the length of the character set to the power of the character count of your ID. (SET_LENGTH^ID_LENGTH)

The default set length is 80 and the default ID length is 16, therefore the default maximum ID count is:<br>
 80^16 = 2.81474976710656 × 10^30 = 2814749767106560000000000000000</p>
 # Compression
 <p>IDs are generated from left to right, leaving many of the same character at the end of each ID.<br>
 
For example, an array of 50000 IDs may have every other ID reversed so that the trailing characters of IDs 1 and 2 (and so on) are together, forming larger patterns for LZW to compress.</p>

See file EXAMPLE.lua to see this implemented.
# Files
<p>seqId.lua : A standalone sequential ID generator. Returns the ID generator function.<br>
seqIdGen.lua : A generator object. Returns a function to create a new generator.</p>
