module main

import os

fn main() {
	if os.args.len < 2 {
		println('No brainfuck code provided, ${os.args}')
		exit(1)
	}

	mut code := os.args[1]
	mut memory := []u8{len: 256}
	mut address := u8(0)

	mut stack := []int{}

	mut trough_code := 0

	for trough_code < code.len {
		match code[trough_code]
		{
			`+` {
				memory[address]++
			}
			`-` {
				memory[address]--
			}
			`>` {
				if address+1 > memory.len {
					break
				}
				address++
			}
			`<` {
				if address-1 < 0 {
					break
				}
				address--
			}
			`.` {
				print(memory[address].ascii_str())
			}
			`,` {
				input := os.input_opt('') or { '' }
				memory[address] = input[0]
			}
			`[` {
				stack << trough_code
			}
			`]` {
				if memory[address] != 0 {
					trough_code = stack[stack.len - 1]
				} else {
					stack.pop()
				}
			}
			else {

			}
		}
		trough_code++
	}

	println('Address value: ${address}')
	println('Memory: ${memory}')
}
