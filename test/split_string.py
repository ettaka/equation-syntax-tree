string = "one,two,three,four,five,test"
string += "one,two,three,four,five,test"
string += "one,two,three,four,five,test"
string += "one,two,three,four,five,test"
string += "one,two,three,four,five,test"
string += "one,two,three,four,five,test"
string += "one,two,three,four,five,test"
string += "one,two,three,four,five,test"
string += "one,two,three,four,five,test"
string += "one,two,three,four,five,test"
string += "one,two,three,four,five,test"
string += "one,two,three,four,five,test"
print(len(string))
for i in range(1000000):
    out = string.split(',')

print(out)
