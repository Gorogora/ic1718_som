#!/usr/bin/perl

# input format
# 5.1,3.5,1.4,0.2,Iris-setosa
# 4.9,3.0,1.4,0.2,Iris-setosa
# 4.7,3.2,1.3,0.2,Iris-setosa


# output format
# @data = (13.575570, 12.656892, -1.424328, -2.302774, 404.921600,
#         16.435490, 17.209114, -1.305744, -1.094125, 399.959900);


print "\@data = (";
while(<>){
  if(/(.*\,)\D*/){
    print $1 . "\n";
  }  
}
print ")\;";
