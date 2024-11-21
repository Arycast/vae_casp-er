import math
def pos_float16_to_bin(num):
    b = ['0'] * 16
    dec_num = int(num)
    exp = 8; frac = 7
    float_num = num - dec_num
    #print(float_num, dec_num)

    b[15] = '0'

    while(dec_num > 0):
        if (dec_num % 2 == 0) : b[exp] = '0'
        else : b[exp] = '1'
        #print(dec_num)
        exp += 1
        dec_num //= 2

    for i in range (7, -1, -1):
        float_num *= 2
        if (float_num == 1): 
            b[frac] = '1'
            break
        elif (float_num > 1):
            b[frac] = '1'
            float_num = float_num - int(float_num)
        else:
            b[frac] = '0'
        frac -= 1
    #print(b)
    return b

def to_fixed_point(num):
   temp_num = 0
   
   if (num < 0): temp_num = -num
   else: temp_num = num
   b = pos_float16_to_bin(temp_num)

   flag = 0
   final = ['0'] * len(b)
   
   for i in range(0, 8): final[i] = b[i]

   if (num < 0):
      for i in range (0, len(b)):
         if (b[i] == '1'):
            if (flag == 0):
               flag = 1
               final[i] = b[i]
            else:
               if (b[i] == '0'): final[i] = '1'
               else: final[i] = '0'
         else:
            if (flag == 0):
               
               final[i] = b[i]
            else:
               if (b[i] == '0'): final[i] = '1'
               else: final[i] = '0'
   else: final = b
   result = ""
   dec = 0

   #print(final)

   for i in range(15,-1,-1):
      if (i == 15 or i == 8): result += str(final[i]) + '_'
      else: result += str(final[i])
      dec += int(final[i]) * (2**i)
   
   return [result, dec]

num = 1.75
res_bin,res_dec = to_fixed_point(num)
print(res_bin,res_dec)