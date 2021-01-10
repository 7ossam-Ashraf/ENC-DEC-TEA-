# Tiny Encryption And Decryption Algorithm




![137240366_1286628748403573_8758737440087715222_n](https://user-images.githubusercontent.com/77072323/104130438-64aade80-5379-11eb-9e30-dd35ffaa8645.png)




## WHAT IS THE TINY ENCRYPTION ALGORITHM?


#### • is one of the fastest and most efficient cryptographic algorithms
#### • It is a Feistel cipher which uses operations from mixed (orthogonal) algebraic groups XOR, ADD and SHIFT in this case
#### • Is providing Shannon's twin properties of diffusion and confusion which are necessary for a secure block cipher
#### • It encrypts 64 data bits at a time using a 128 bit key
#### • a one bit difference in the plaintext will cause approximately 32 bit differences in the ciphertext


## USAGE AND SELECTIONS


#### • This algorithm are replaced then DES in software
#### • Is short enough to write into almost any program on any c
#### • Is not a speed with 32 cycle ( 64 round)
#### • That implementations is three time fast and enhancement software implementation then DES that have 16 rounds
#### • It is expected that security can be enhanced by increasing the number of iterations
#### • The selections of algorithm (fast , safety , easy implantations , responsible (performance )


## CODE EXPLAIN


#### • Tiny encryption are used XOR and ADD to provide nonlinearity, and add and sub are used for encryption and decryption rather then XOR
#### • A dual shift causes all bits of the key and data to be mixed repeatedly
#### • The number of rounds can be 16 cycles ( 32 iterations) or 32 cycles ( 64 iterations
#### • The key is set at 128 bits as this is enough to prevent simple search techniques from finding the key [ 4 ].
#### • The constant number, delta, is derived from thegolden number ratio [ 4 ]
####  𝒅𝒆𝒍𝒕𝒂=𝟓−𝟏∗𝟐𝟑𝟏=9E3779B9h


![137551308_3397240057054479_3141500891801217952_n](https://user-images.githubusercontent.com/77072323/104130728-054dce00-537b-11eb-98b8-47588e8c3235.png)




## C CODE FOR TINY




![137016076_123635929583242_8926388524428482905_n](https://user-images.githubusercontent.com/77072323/104131229-cff6af80-537d-11eb-8efe-f17a96dc2d60.png)




## The Output




![136654806_231669515187593_8362393164828897982_n](https://user-images.githubusercontent.com/77072323/104131269-0f250080-537e-11eb-8a5a-5b0f8d1ed9e9.png)




## c CODE FOR DECRYPTION 




![136767085_148810240340475_6845425757099889094_n](https://user-images.githubusercontent.com/77034137/104136547-a0f13580-539f-11eb-9a64-40ba370e8e2b.png)





## the output





![136504767_995781054164406_2213960694890753885_n](https://user-images.githubusercontent.com/77034137/104136555-ababca80-539f-11eb-8d30-d33ef02c6906.png)





## output code Assembly language encryption and decryption




![137333743_875797406524937_1148626798393614117_n](https://user-images.githubusercontent.com/77034137/104136294-deed5a00-539d-11eb-97e6-9e9e705b1ff2.png)




## • BY 5G TEAM

### • ALAA RAMADAN HASSAN AHMED
### • HOSSAM ASHRAF MOAWAD
### • MOHAMED MOHSEN
### • ZEYED MOHSEN
### • KARIM ABDELQADER ABDELMONEEM
