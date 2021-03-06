C    Copyright(C) 1988 National Technology & Engineering Solutions
C    of Sandia, LLC (NTESS).  Under the terms of Contract DE-NA0003525 with
C    NTESS, the U.S. Government retains certain rights in this software.
C    
C    Redistribution and use in source and binary forms, with or without
C    modification, are permitted provided that the following conditions are
C    met:
C    
C    * Redistributions of source code must retain the above copyright
C       notice, this list of conditions and the following disclaimer.
C              
C    * Redistributions in binary form must reproduce the above
C      copyright notice, this list of conditions and the following
C      disclaimer in the documentation and/or other materials provided
C      with the distribution.
C                            
C    * Neither the name of NTESS nor the names of its
C      contributors may be used to endorse or promote products derived
C      from this software without specific prior written permission.
C                                                    
C    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
C    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
C    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
C    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
C    OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
C    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
C    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
C    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
C    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
C    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
C    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

C $Id: gmtch2.f,v 1.1 1991/02/21 15:43:31 gdsjaar Exp $
C $Log: gmtch2.f,v $
C Revision 1.1  1991/02/21 15:43:31  gdsjaar
C Initial revision
C
      SUBROUTINE GMTCH2 (COORD, DIRCOS, MASSLV, NIQSLV, TDIS,
     *    NIQM, NIQS, DMAX, NUMNP)
      DIMENSION COORD (NUMNP,*), DIRCOS(4,*), MASSLV(2,*), NIQSLV(*),
     *    TDIS(3,*)
C
      DO 30 IMAS = 1, NIQM
          X1 = COORD (MASSLV(1, IMAS),1)
          Y1 = COORD (MASSLV(1, IMAS),2)
C
          DCS1 = DIRCOS (1, IMAS)
          DCS2 = DIRCOS (2, IMAS)
C
          DO 10 ISLV = 1, NIQS
              X0 = COORD (NIQSLV(ISLV),1)
              Y0 = COORD (NIQSLV(ISLV),2)
C
              T = -( DCS1 * (X1-X0) + DCS2 * (Y1-Y0) )
              TDIS(1,ISLV) = T
              TDIS(2,ISLV) = (X1 + DCS1 * T - X0)**2  +
     *            (Y1 + DCS2 * T - Y0)**2
              TDIS(3,ISLV) = T**2 + TDIS(2,ISLV)
   10     CONTINUE
C
          TMIN = 1.0E38
          NMIN = 0
          DO 20 ISLV = 1, NIQS
              IF (TDIS(2,ISLV) .LT. TMIN .AND. TDIS(3,ISLV) .LE. DMAX)
     *            THEN
                  TMIN = TDIS(2,ISLV)
                  NMIN = ISLV
              END IF
   20     CONTINUE
C
          IF (NMIN .NE. 0) THEN
              DIRCOS(3,IMAS) = TDIS(1,NMIN)
              DIRCOS(4,IMAS) = SQRT(TDIS(2,NMIN))
              MASSLV(2,IMAS) = NIQSLV(NMIN)
          ELSE
              MASSLV(2,IMAS) = 0
          END IF
   30 CONTINUE
      CALL CULL2 (DIRCOS, MASSLV, NIQM)
      RETURN
      END
