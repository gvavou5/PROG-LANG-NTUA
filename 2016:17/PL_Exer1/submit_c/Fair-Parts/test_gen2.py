import random
import sys

if len(sys.argv) == 3:
    instances = int(sys.argv[1])
    bars = int(sys.argv[2])
elif len(sys.argv) == 2:
    instances = int(sys.argv[1])
    bars = random.randrange(instances)

generated = open('test_case_' + str(instances) + '_' + str(bars) + '.txt', 'w')
generated.write(str(instances) + ' ' + str(bars) + '\n')

generated.write(str(random.randrange(10000000)))
for idx in range(instances - 1):
    number = random.randrange(10000000)
    generated.write(' ' + str(number))

generated.close()
