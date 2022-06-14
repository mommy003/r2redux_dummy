#' olkin12_13 function
#' @export
#' @importFrom stats D cor dnorm lm logLik pchisq qchisq qnorm
#' @param 
#' @keywords 
#' @return


  olkin12_13 = function (omat,nv) {

  #aova in p158 in Olkin and Finn (using my own code)
  av=array(0,5)
  f=expression((c22 * ((c33/(c22 * c33 - c32^2)) * c21 + (c32/(c32^2 - 
    c22 * c33)) * c31)^2 + 2 * c32 * (((c33/(c22 * c33 - c32^2)) * 
    c21 + (c32/(c32^2 - c22 * c33)) * c31) * ((c32/(c32^2 - c22 * 
    c33)) * c21 + (c22/(c22 * c33 - c32^2)) * c31)) + c33 * ((c32/(c32^2 - 
    c22 * c33)) * c21 + (c22/(c22 * c33 - c32^2)) * c31)^2) - 
    (c22 * ((c44/(c22 * c44 - c42^2)) * c21 + (c42/(c42^2 - c22 * 
        c44)) * c41)^2 + 2 * c42 * (((c44/(c22 * c44 - c42^2)) * 
        c21 + (c42/(c42^2 - c22 * c44)) * c41) * ((c42/(c42^2 - 
        c22 * c44)) * c21 + (c22/(c22 * c44 - c42^2)) * c41)) + 
        c44 * ((c42/(c42^2 - c22 * c44)) * c21 + (c22/(c22 * 
            c44 - c42^2)) * c41)^2))
  c11=omat[1,1]
  c21=omat[2,1]
  c22=omat[2,2]
  c31=omat[3,1]
  c32=omat[3,2]
  c33=omat[3,3]
  c41=omat[4,1]
  c42=omat[4,2]
  c43=omat[4,3]
  c44=omat[4,4]

  av[1]=eval(D(f,'c21'))
  av[2]=eval(D(f,'c31'))
  av[3]=eval(D(f,'c41'))
  av[4]=eval(D(f,'c32'))
  av[5]=eval(D(f,'c42'))


  ov=matrix(0,5,5)
  ov[1,1]=(1-omat[2,1]^2)^2/nv
  ov[2,2]=(1-omat[3,1]^2)^2/nv
  ov[3,3]=(1-omat[4,1]^2)^2/nv
  ov[4,4]=(1-omat[3,2]^2)^2/nv
  ov[5,5]=(1-omat[4,2]^2)^2/nv

  ov[2,1]=(0.5*(2*omat[3,2]-omat[2,1]*omat[3,1])*(1-omat[3,2]^2-omat[2,1]^2-omat[3,1]^2)+omat[3,2]^3)/nv
  ov[1,2]=ov[2,1]

  ov[3,1]=(0.5*(2*omat[4,2]-omat[2,1]*omat[4,1])*(1-omat[4,2]^2-omat[2,1]^2-omat[4,1]^2)+omat[4,2]^3)/nv
  ov[1,3]=ov[3,1]

  ov[3,2]=(0.5*(2*omat[4,3]-omat[3,1]*omat[4,1])*(1-omat[4,3]^2-omat[3,1]^2-omat[4,1]^2)+omat[4,3]^3)/nv
  ov[2,3]=ov[3,2]

  ov[4,1]=(0.5*(2*omat[3,1]-omat[2,1]*omat[3,2])*(1-omat[3,2]^2-omat[2,1]^2-omat[3,1]^2)+omat[3,1]^3)/nv
  ov[1,4]=ov[4,1]

  ov[4,2]=(0.5*(2*omat[2,1]-omat[3,1]*omat[3,2])*(1-omat[3,2]^2-omat[2,1]^2-omat[3,1]^2)+omat[2,1]^3)/nv
  ov[2,4]=ov[4,2]

  ov[4,3]=omat[2,1]^2+omat[3,1]^2+omat[4,2]^2+omat[4,3]^2
  ov[4,3]=ov[4,3]*0.5*omat[4,1]*omat[3,2]
  ov[4,3]=ov[4,3]+omat[2,1]*omat[4,3]+omat[3,1]*omat[4,2]
  ov[4,3]=ov[4,3]-omat[4,1]*omat[2,1]*omat[3,1]
  ov[4,3]=ov[4,3]-omat[4,1]*omat[4,2]*omat[4,3]
  ov[4,3]=ov[4,3]-omat[2,1]*omat[4,2]*omat[3,2]
  ov[4,3]=ov[4,3]-omat[3,1]*omat[4,3]*omat[3,2]
  ov[4,3]=ov[4,3]/nv 
  ov[3,4]=ov[4,3] 


  ov[5,1]=(0.5*(2*omat[4,1]-omat[2,1]*omat[4,2])*(1-omat[4,2]^2-omat[2,1]^2-omat[4,1]^2)+omat[4,1]^3)/nv
  ov[1,5]=ov[5,1]

  
  ov[5,2]=omat[2,1]^2+omat[4,1]^2+omat[3,2]^2+omat[4,3]^2
  ov[5,2]=ov[5,2]*0.5*omat[3,1]*omat[4,2]
  ov[5,2]=ov[5,2]+omat[2,1]*omat[4,3]+omat[4,1]*omat[3,2]
  ov[5,2]=ov[5,2]-omat[3,1]*omat[2,1]*omat[4,1]
  ov[5,2]=ov[5,2]-omat[3,1]*omat[3,2]*omat[4,2]
  ov[5,2]=ov[5,2]-omat[2,1]*omat[3,2]*omat[4,2]
  ov[5,2]=ov[5,2]-omat[4,1]*omat[4,3]*omat[4,2]
  ov[5,2]=ov[5,2]/nv 
  ov[2,5]=ov[5,2] 


  ov[5,3]=(0.5*(2*omat[2,1]-omat[4,1]*omat[4,2])*(1-omat[4,2]^2-omat[2,1]^2-omat[4,1]^2)+omat[2,1]^3)/nv
  ov[3,5]=ov[5,3]

  ov[5,4]=(0.5*(2*omat[4,3]-omat[3,2]*omat[4,2])*(1-omat[4,2]^2-omat[4,3]^2-omat[3,2]^2)+omat[4,3]^3)/nv
  ov[4,5]=ov[5,4]



  #variance of the difference
  aova=t(av)%*%ov%*%(av)
  #return(aova) 

  }

