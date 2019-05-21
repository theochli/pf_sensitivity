C    program parflowslopes creates ParFlow slope input files
C    written by Michael Barnes 2012 (C) 
C    see GPL
C    main program  
      program parflowslopes
      implicit none
C    file names
      character(100) fnam, outfil, flofil, rivfil, slopexfil, slopeyfil
C    resolution
      double precision dx, dy, dz
C    extent
      integer nx, ny, nz
C      parameter (nx=2016, ny=1517, nz=1)
C      parameter (dx=1.0d0, dy=1.0d0, dz=10.0d0)
C    slope for rivers, minimum slope
      double precision rivslo, minslo
C    index and error integer
      integer i, j, err 
C    dem array  
      double precision, allocatable :: array(:,:)
C    slope arrays
      double precision, allocatable :: sx(:,:), sy(:,:)
C    flow direction grid  array
      integer, allocatable :: flodir(:,:)
C    stream cell array
      integer, allocatable :: river(:,:)
C     END SPECIFICATIONS
      read(*,*) fnam, flofil, rivfil, slopexfil, slopeyfil, outfil,
     .          nx, ny, nz, dx, dy, dz, rivslo, minslo
      write(UNIT=*,FMT='(A)') 'parflowslopes' 
     .                  //' written by Michael Barnes'
      write(UNIT=*,FMT='(A)') 'This is free software under GNU GPL' 
      print*, ''
      print*, 'read input parameters:'
      print*, 'DEM file: ', fnam
      print*, 'Flow Direction file: ', flofil 
      print*, 'River file: ', rivfil
      print*, 'Dimensions: ', nx,'*',ny
      print*, 'Resolution: ', dx,',',dy
C      make allocations
      allocate(array(nx,ny))
      allocate(sx(nx,ny))
      allocate(sy(nx,ny))
      allocate(flodir(nx,ny))
      allocate(river(nx,ny))
C      open files 
      print*, 'opening files'
      open(11,file=fnam,iostat=err, status='old')
      if(err.ne.0) stop 'error opening input dem text file'
      open(12,file=outfil,iostat=err, status='unknown')
      if(err.ne.0) stop 'error opening dem output text file'
      open(13,file=flofil,iostat=err, status='old')
      if(err.ne.0) stop 'error opening flow direction file'
      open(14,file=rivfil,iostat=err, status='old')
      if(err.ne.0) stop 'error opening river file'
C      read files
      print*, 'reading input files'
      do j = 1,ny
                read(11,*) (array(i,(ny+1)-j),i=1,nx)
                write(12,*) (array(i,(ny+1)-j),i=1,nx) 
      end do
      do j = 1,ny
                read(13,*) (flodir(i,(ny+1)-j), i=1,nx)
      end do
      do j = 1,ny
                read(14,*) (river(i,(ny+1)-j), i=1,nx)
      end do
      print*, 'calculating slopes'
      call slopes(
     I            array,flodir,river,nx,ny,
     I             dx,dy,rivslo,minslo,
     O             sx, sy)
      print*, 'dx: ', dx
      print*, 'dy: ', dy
      print*, 'writing output files'
      call pf_write(sx,slopexfil,nx,ny,nz,dx,dy,dz)
      call pf_write(sy,slopeyfil,nx,ny,nz,dx,dy,dz)
      deallocate(array)
      deallocate(flodir)
      deallocate(river)
      close(11,iostat=err)
      if(err.ne.0) stop 'error closing file'
      close(12,iostat=err)
      if(err.ne.0) stop 'error closing file'
      close(13,iostat=err)
      if(err.ne.0) stop 'error closing file'
      close(14,iostat=err)
      if(err.ne.0) stop 'error closing file'
      end program
