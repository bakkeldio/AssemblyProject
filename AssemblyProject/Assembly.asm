INCLUDE Irvine32.inc
.386
.MODEL flat,stdcall
.STACK 4096
ExitProcess PROTO,dwExitCode:DWORD
WriteString PROTO
ReadDec PROTO

.DATA

promptLineOne BYTE "1.  X + Y ",0
promptLineTwo BYTE "2.  X - Y ",0
promptLineThree BYTE "3.  X * Y ",0
promptLineFour BYTE "4.  X / Y  ",0
promptLineFive BYTE "5.  X mod Y ",0
operation BYTE "Select number of operation: ",0
promptNum1 BYTE "Enter X: ",0
promptNum2 BYTE "Enter Y: ",0
added BYTE "The sum of X and Y is: ",0
multiplied BYTE "The product of X and Y is: ",0
divided BYTE "The quotient of X and Y is: ",0
substracted BYTE "The difference of X and Y is: ",0
remainder BYTE "The remainder of X and Y is: ",0
modStr BYTE "The mod of X and Y is: ",0
wantToContinue BYTE "Do you want to continue? ",0
option1 BYTE "0 - no",0
option2 BYTE "1 -yes",0
choiceStr BYTE "Enter your choice: ",0


operationToPerform DWORD 0
num1 DWORD ?
num2 DWORD ?
result DWORD ?
remain DWORD ?
choice DWORD ?

.CODE

prompt PROC
  MOV ECX,5
  MOV EAX,0
  MOV EDI,OFFSET promptLineOne
  L1:
    MOV EDX,EDI
    INVOKE WriteString
    INVOKE CrLf
    L2:
        INC EDI
        MOV AL,[EDI]
        CMP EAX,0
        JNZ L2
        INC EDI
    LOOP L1

RET
prompt ENDP

calculate PROC

L1:

    mov edx, OFFSET promptNum1
    call WriteString
    call ReadDec
    MOV num1, EAX
 
    mov Edx, OFFSET promptNum2
    call WriteString
    Invoke ReadDec
    MOV num2,EAX

    mov edx, OFFSET operation
    call WriteString
    call ReadDec
    mov operationToPerform, eax

    Operation1:
        mov edx,1
        cmp edx, operationToPerform
        je Addition
    Operation2:
        mov edx, 2
        cmp edx, operationToPerform
        je Substraction

    Operation3:
        mov edx, 3
        cmp edx, operationToPerform
        je Multiplication
    Operation4:
        mov edx, 4
        cmp edx, operationToPerform
        je Division

    Operation5:
        mov edx, 5
        cmp edx, operationToPerform
        je Ostatok
   

    Addition:

        MOV EAX,num1
        ADD EAX,num2
        MOV result,EAX

        MOV EDX,OFFSET added
        INVOKE WriteString
        MOV EAX, result
        call WriteDec
        
        call CrLf
        jmp Continue

    Substraction:

        MOV EAX, num1
        SUB EAX, num2
        MOV result, EAX

       
        MOV EDX, OFFSET substracted
        call WriteString
        mov EAX, result
        call WriteDec

        call CrLf
        jmp Continue


    Multiplication:
        mov eax, num1
        mov ebx, num2
        mul ebx
        mov result, EAX

        MOV EDX, OFFSET multiplied
        INVOKE WriteString
        MOV EAX, result
        call WriteDec

        call CrLf
        jmp Continue

    Ostatok: 
        mov eax,num1
        mov ebx, num2
        xor edx, edx
        div ebx
        mov result, edx

        mov edx, offset modStr
        call WriteString

        MOV EAX,result
        call WriteDec
        call CrLf

        jmp Continue


    Division:

        mov eax,num1
        mov ebx, num2
        xor edx, edx
        div ebx
        mov result, eax
        mov remain, edx

        MOV EDX, OFFSET divided
        call WriteString

        MOV EAX, result
        call WriteDec
        call CrLf


        MOV EDX, OFFSET remainder
        call WriteString
        MOV EAX, remain
        call WriteDec

        call CrLf


        jmp Continue
        

      
    Continue: 
        mov edx, offset wantToContinue
        call WriteString
        call CrLf


        mov edx, offset option1
        call WriteString
        call CrLf

        mov edx, offset option2
        call WriteString
        call CrLf

        mov edx, offset choiceStr
        call WriteString
        call ReadDec
        mov choice, eax
        
        mov edx, 1
        cmp edx, choice
        je L1

        ret
       

calculate ENDP


_start PROC
  INVOKE prompt
  INVOKE calculate

  INVOKE ExitProcess,0
_start ENDP

END _start