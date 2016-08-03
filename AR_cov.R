AR.cov = read.table("AR_perbase_cov.txt")

library(ggplot2)

# this plot is per base depth of AR region. Too noisy
ggplot(AR.cov, aes(x=V2, y=V3)) + geom_line() + theme_bw()

# 66790 66840

# This compute mean depth per n base, and plot

left = 67670000

right = 67709000


n <- 1000;
per.n.depth = 
  aggregate(AR.cov,list(rep(1:(nrow(AR.cov)%/%n+1),each=n,len=nrow(AR.cov))),mean)[-1]

ggplot(per.n.depth, aes(x=V2, y=V3))  + geom_area(fill="darkblue", alpha=1) + theme_bw() + 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
       panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  geom_vline(xintercept = c(left,right))
#+ geom_smooth()

ggsave(filename = "AR.coverage.pdf",width = 10,height = 5)

# do t.test, show significant duplicate




reg.length = right-left

#left.region = c( (left-reg.length) : left  )

left.region = c( 67640000:left  )

middle.region = c(left,right)

right.region = c(right:67730619)

left.region.cov = per.n.depth$V3[match(left.region,per.n.depth$V2)]

right.region.cov = per.n.depth$V3[match(right.region,per.n.depth$V2)]

middle.region.cov = per.n.depth$V3[match(middle.region,per.n.depth$V2)]


t.test(na.omit(left.region.cov),na.omit(middle.region.cov) )

mean(na.omit(left.cov) )

mean(na.omit(right.cov) )

####

# in per.n.depth, row 122-161 is duplicated region.

t.test(per.n.depth$V3[c(122:161)], per.n.depth$V3[c(122-39:122) ])
t.test(per.n.depth$V3[c(122:161)], per.n.depth$V3[c(161:nrow(per.n.depth)) ])

