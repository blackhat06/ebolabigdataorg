Advanced - Robust and GAM Modeling

#Robust Regression - eliminates or mutes outliers
lmFit<-lm(Cases~area+gender+Doct+age+beds,data=nrha,na.action=na.omit); summary(lmFit);
robMMFit<-lmRobMM(Cases~area+gender+Doct+age+beds,data=nrha,na.action=na.omit);
                        summary(robMMFit);
ltsFit<-ltsreg(Cases~area+gender+Doct+age+beds,data=nrha,na.action=na.omit);
                        summary(ltsFit);
lmsFit<-lmsreg(Cases~area+gender+Doct+age+beds,data=nrha,na.action=na.omit);
                        summary(lmsFit);

#compare coefficients from OLS and from Robust methods
coefdf<-as.data.frame(rbind(coefficients(lmFit),coefficients(robMMFit),coefficients(ltsFit),coefficients(lmsFit))*1000)
row.names(coefdf)<-c("ols","lmRobMM","lts","lms")
coefdf

#GAM - General Additive Modeling- Nonlnear, Nonparametric regression/modeling
names(nrha)
        gamFit<-gam(Cases~s(area)+s(gender,1)+s(age)+s(Doct)+s(beds,2),na.action=na.omit,data=nrha);
                cor(predict(gamFit),predict(gamFit)+resid(gamFit))^2    # pseudo r2
                 par(mfcol=c(3,3)); plot.gam(gamFit)
                plot(predict(gamFit),predict(gamFit)+resid(gamFit))

        gamFit<-gam(Cases~s(area)+s(age)+s(Doct)+s(beds),na.action=na.omit,data=nrha); 
                cor(predict(gamFit),predict(gamFit)+resid(gamFit))^2    # pseudo r2
                par(mfcol=c(2,2)); plot.gam(gamFit); plot(predict(gamFit),predict(gamFit)+resid(gamFit))

        predict(gamFit,osdf)*1000   # get predicted value of your ebola cases
