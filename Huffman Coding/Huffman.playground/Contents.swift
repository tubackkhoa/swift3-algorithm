//: Playground - noun: a place where people can play

import Foundation

let s1 = "so much words wow many compression"

#if swift(>=3.0)
if let originalData = s1.data(using: String.Encoding.utf8) {
  print(originalData.count)
  
  let huffman1 = Huffman()
  let compressedData = huffman1.compressData(originalData as NSData)
  print(compressedData.length)
  
  let frequencyTable = huffman1.frequencyTable()
  print(frequencyTable)
  // NSData and Data can be unwrap using Data.first!, or simple "as" operator
  let huffman2 = Huffman()
  let decompressedData = huffman2.decompressData(compressedData, frequencyTable: frequencyTable)
  print(decompressedData.length)
  
  let s2 = String(data: decompressedData as Data, encoding: String.Encoding.utf8)!
  print(s2)
  assert(s1 == s2)
}
#else
if let originalData = s1.dataUsingEncoding(NSUTF8StringEncoding) {
  print(originalData.length)
  
  let huffman1 = Huffman()
  let compressedData = huffman1.compressData(originalData)
  print(compressedData.length)
  
  let frequencyTable = huffman1.frequencyTable()
  //print(frequencyTable)
  
  let huffman2 = Huffman()
  let decompressedData = huffman2.decompressData(compressedData, frequencyTable: frequencyTable)
  print(decompressedData.length)
  
  let s2 = String(data: decompressedData, encoding: NSUTF8StringEncoding)!
  print(s2)
  assert(s1 == s2)
}
#endif


