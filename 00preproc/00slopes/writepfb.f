C    program parflowslopes creates ParFlow slope input files
C    written by Michael Barnes 2012 (C)
C    see GPL
C    subroutine pf_write per ParFlow pftools prepostproc w/o subgrids 
      subroutine pf_write(x,filename,ixlim,iylim,izlim,dx,dy,dz)
      implicit none
      integer i,j,k, ixlim, iylim, izlim, 
     .          ns, ix, iy, iz, rx, ry, rz
      real*8 x(ixlim,iylim,izlim),dx, dy, dz, x1, y1, z1
      character(len=*) filename
C
C     Open File
C
      print*, filename
      open(15,file=filename,form='unformatted',
     .     access='stream',convert='BIG_ENDIAN', status='unknown')
C
C Calc domain bounds
C
      ix = 0
      iy = 0
      iz = 0

      ns = 1

      rx = 1
      ry = 1
      rz = 1

      x1 = dble(ixlim)*dx
      y1 = dble(iylim)*dy
      z1 = dble(izlim)*dz
C
C       Write header info
C
      write(15) x1
      write(15) y1
      write(15) z1

      write(15) ixlim
      write(15) iylim
      write(15) izlim

      write(15) dx
      write(15) dy
      write(15) dz

      write(15) ns

      write(15) ix
      write(15) iy
      write(15) iz

      write(15) ixlim
      write(15) iylim
      write(15) izlim

      write(15) rx
      write(15) ry
      write(15) rz


      do  k=1,izlim
           do  j=1,iylim
                do  i=1,ixlim
                     write(15) x(i,j,k)
                end do
           end do
      end do

      close(15)
      return
      end
