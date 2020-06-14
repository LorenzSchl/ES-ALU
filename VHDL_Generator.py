#STIMULI_FILE_PATH = "S:/Uni/stimuli.txt"
#EXPECTED_FILE_PATH = "S:/Uni/expected.txt"
STIMULI_FILE_PATH = "/home/lorsch/Daten/FHDW/6. Semester/ES/Projekte/ES-ALU/stimuli.txt"
EXPECTED_FILE_PATH = "/home/lorsch/Daten/FHDW/6. Semester/ES/Projekte/ES-ALU/expected.txt"


OPERANTS = [
    (lambda a, b : (bin(a+b & 0b11111111), bin(a+b > 255)), "0000"),
    (lambda a, b : (bin(a-b & 0b11111111) if a>b else bin(0b00000000), bin(a<b)), "0001"),
    (lambda a, b : (bin(b-a & 0b11111111) if b>a else bin(0b00000000), bin(b<a)), "0010"),
    (lambda a, b : (bin(a), bin(0)), "0011"),
    (lambda a, b : (bin(b), bin(0)), "0100"),
    (lambda a, b : (bin(flip_bits(bin(a))), bin(0)), "0101"),
    (lambda a, b : (bin(flip_bits(bin(b))), bin(0)), "0110"),
    (lambda a, b : ((bin(int(bin(a << 1)[-8:], 2))) if len(bin(a << 1)) > 10 else (bin(int(bin(a << 1)[2:].zfill(8), 2))), bin(0)), "0111"),
    (lambda a, b : (bin(a >> 1), bin(0)), "1000"),
    (lambda a, b : (bin(rotate_left(bin(a))), bin(0)), "1001"),
    (lambda a, b : (bin(rotate_right(bin(a))), bin(0)), "1010"),
    (lambda a, b : (bin(a*b), bin(0)), "1011"),
    (lambda a, b : (bin(flip_bits(bin(a&b))), bin(0)), "1100"),
    (lambda a, b : (bin(a^b), bin(0)), "1101")
]

def main():
    for func, op in OPERANTS:
        for a in range(0, 255, 10):
            for b in range(0, 255, 10):                
                if(op == "1011"):
                    (flow, carry) = func(a, b)
                    flow = flow[2:].zfill(16)
                    write_expected(f"{flow[:8]} {flow[-8:]} {carry[2:]} {bin(a==b)[2:]}")
                    write_stimuli(f"{bin(a)[2:].zfill(8)} {bin(b)[2:].zfill(8)} {op}")
                else:
                    (flow, carry) = func(a, b)
                    write_expected(f"00000000 {flow[2:].zfill(8)} {carry[2:]} {bin(a==b)[2:]}")
                    write_stimuli(f"{bin(a)[2:].zfill(8)} {bin(b)[2:].zfill(8)} {op}")

def write_stimuli(line):
    with open(STIMULI_FILE_PATH, "a+") as stimuli:
        stimuli.writelines(f"{line}\n")

def write_expected(line):
    with open(EXPECTED_FILE_PATH, "a+") as expected:
        expected.writelines(f"{line}\n")

def flip_bits(input):
    output = "0b"
    output += input[2:].zfill(8).replace('1', '2').replace('0', '1').replace('2', '0')

    return int(output, 2)

def rotate_left(input):
    output = "0b"
    output += input[2:].zfill(8)[1:] + input[2:].zfill(8)[:1]

    return int(output, 2)

def rotate_right(input):
    output = "0b"
    output += input[2:].zfill(8)[-1:] + input[2:].zfill(8)[:-1]

    return int(output, 2)

if __name__ == "__main__":
    """ This is executed when run from the command line """
    main()
