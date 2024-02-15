function asm32 --wraps=/usr/include/asm/unistd_32.h --wraps='cat /usr/include/asm/unistd_32.h' --description 'alias asm32=cat /usr/include/asm/unistd_32.h'
  cat /usr/include/asm/unistd_32.h $argv
        
end
