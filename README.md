# An RISCV 32 bit core built from scratch using system verilog

>[!Note]
> - Educational purposes
> - No specific features yet
> - The ALU is part of a git submodule
>   - Do `git clone --recurse-submodules <url>`
>   - Or place the alu files (from the sys_ver branch in this [repo](https://github.com/Daedalus-op/ALU/tree/sys_ver) ) in `./src/3.Execution/ALU` folder
>   - Or use the zip file in `./Vivado_Project_Files/RV.zip` as a vivado project

# Status
- [x] Instruction Fetch
	- [x] Design
	- [x] Testing
- [x] Instruction Decode
	- [x] Design
	- [x] Testing
- [x] Execution
	- [x] Design
	- [x] Testing
- [x] Memory Access
	- [x] Design
	- [x] Testing
- [x] Write Back
	- [x] Design
	- [x] Testing

# Extensions
- I - Integer

# TODO
- Extensions
- [ ] G - IMAFD 
	- [ ] Zicsr Zfencei
	- [ ] M - Muliplication
	- [ ] F - Single point floating
	- [ ] D - Double point floating
	- [ ] A - Atomics
- Multicycle
- Pipelined
