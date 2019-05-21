C    program parflowslopes creates ParFlow slope input files 
C    written by  Michael Barnes 2012 (C)
C    see GPL   
C    subroutine slopes
C    slope calculator
      subroutine slopes
     I                 (x,flodir,river,ixlim,iylim,
     I                  dx,dy,rivslo,minslo,
     O                  sx,sy)
      implicit none
C     DUMMY ARGUMENTS
C     x and y domain dimensions 
      integer ixlim, iylim
C     DEM array, x resolution, y resolution 
      double precision x(ixlim,iylim), dx, dy
C     X slope array, Y slope array
      double precision sx(ixlim,iylim), sy(ixlim,iylim)
C     Slope applied to stream cells, minimum slope threshold
      double precision rivslo,minslo
C     Flow direction grid from grass
      integer flodir(ixlim,iylim)
C     Stream cell grid from grass
      integer river(ixlim,iylim)
C     LOCAL VARIABLES
C     indexes
      integer i, j 
C     END SPECIFICATIONS
C     begin loop over elevation array
C     Loop over input array, treat upper and right border differently
      do i=1,ixlim
           do j=1,iylim
C     slopes magnitudes in x and y direction
                   if(i.lt.ixlim.and.j.lt.iylim) then
                        sx(i,j) =(x(i+1,j)-x(i,j))/(dx) 
                        sy(i,j) =(x(i,j+1)-x(i,j))/(dy)
                   end if
                   if(i.eq.ixlim.and.j.lt.iylim) then
                        sx(i,j) =sx(i-1,j)
                        sy(i,j) =(x(i,j+1)-x(i,j))/(dy)
                   end if
                   if(i.lt.ixlim.and.j.eq.iylim) then
                        sx(i,j) =(x(i+1,j)-x(i,j))/(dx)
                        sy(i,j) =sy(i,j-1)
                   end if
                   if(i.eq.ixlim.and.j.eq.iylim) then
                        sx(i,j) =(sx(i-1,j))
                        sy(i,j) =(sy(i,j-1))
                   end if
C     impose minimum slope threshold
                   if(abs(sx(i,j)).lt.minslo) sx(i,j)=minslo
                   if(abs(sy(i,j)).lt.minslo) sy(i,j)=minslo
C     give channel network a constant linear slope 
                   if(river(i,j).ne.0) then
                        sx(i,j) = rivslo
                        sy(i,j) = rivslo
                   end if
C     enforce single flow direction throughout domain
C     based on GRASS r.watershed derived flow direction
C     NORTH
                   if(abs(flodir(i,j)).eq.2) then 
                        sy(i,j) = -abs(sy(i,j))
C                        if(river(i,j).ne.0) then
                             sx(i,j) = 0.0d0
C                        end if
                        cycle
                   end if
C     WEST
                   if(abs(flodir(i,j)).eq.4) then
                        sx(i,j) = abs(sx(i,j))
C                        if(river(i,j).ne.0) then
                             sy(i,j) = 0.0d0
C                        end if
                        cycle
                   end if
C     SOUTH 
                   if(abs(flodir(i,j)).eq.6) then
                        sy(i,j) = abs(sy(i,j))
C                        if(river(i,j).ne.0) then
                             sx(i,j) = 0.0d0
C                        end if
                        cycle
                   end if
C     EAST         
                   if(abs(flodir(i,j)).eq.8) then
                        sx(i,j) = -abs(sx(i,j))
C                        if(river(i,j).ne.0) then
                             sy(i,j) = 0.0d0
C                        end if
                        cycle
                   else
                        stop 'no conditions met'
                   end if
           end do
      end do
      return
      end subroutine
