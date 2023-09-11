!
! MWwaterLUT_Inspect
!
! Program to inspect the contents of an MWwaterLUT file.
!
!
! CREATION HISTORY:
!       Written by:     Paul van Delst, 14-Dec-2011
!                       paul.vandelst@noaa.gov
!

PROGRAM MWwaterLUT_Inspect

  ! ------------------
  ! Environment set up
  ! ------------------
  ! Module usage
  USE File_Utility     , ONLY: File_Exists
  USE Message_Handler  , ONLY: SUCCESS, FAILURE, Program_Message, Display_Message
  USE MWwaterLUT_Define, ONLY: MWwaterLUT_type, &
                               MWwaterLUT_Destroy, &
                               MWwaterLUT_ReadFile, &
                               Inspect => MWwaterLUT_Inspect
  ! Disable implicit typing
  IMPLICIT NONE

  ! ----------
  ! Parameters
  ! ----------
  CHARACTER(*), PARAMETER :: PROGRAM_NAME = 'MWwaterLUT_Inspect'
  !CHARACTER(*), PARAMETER :: PROGRAM_VERSION_ID = &

  ! ---------
  ! Variables
  ! ---------
  INTEGER :: err_stat
  CHARACTER(256) :: msg, filename
  TYPE(MWwaterLUT_type) :: C

  ! Output program header
  CALL Program_Message( PROGRAM_NAME, &
                        'Program to display the contents of an '//&
                        'MWwaterLUT file to stdout.', &
                        '$Revision$' )

  ! Get the filename
  WRITE( *,FMT='(/5x,"Enter the MWwaterLUT filename: ")',ADVANCE='NO' )
  READ( *,'(a)' ) filename
  filename = ADJUSTL(filename)
  IF ( .NOT. File_Exists( TRIM(filename) ) ) THEN
    msg = 'File '//TRIM(filename)//' not found.'
    CALL Display_Message( PROGRAM_NAME, msg, FAILURE ); STOP
  END IF

  ! Read the binary data file
  err_stat = MWwaterLUT_ReadFile( C, filename )
  IF ( err_stat /= SUCCESS ) THEN
    msg = 'Error reading MWwaterLUT file '//TRIM(filename)
    CALL Display_Message( PROGRAM_NAME, msg, FAILURE ); STOP
  END IF

  ! Display the contents
  CALL Inspect( C, pause=.TRUE. )

  ! Clean up
  CALL MWwaterLUT_Destroy( C )

END PROGRAM MWwaterLUT_Inspect
