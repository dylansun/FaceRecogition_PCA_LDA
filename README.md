## Read me
This repos uses the ORL dataset, which you may obtain the raw images from here[1].

In my experiment settings, I use the first 7 image of each person as train, and the rest as test, the data is saved in `data.mat`

The main idea is to use PCA to project the image in the low dimension subspace. And afterwards use linear discriminent analysis( also knowns as the Fisher LDA) to achieve the classification tasks.

Since the code is writen about 2 years ago, which is my first try of face recognition task, I forgot the details of the code. I may add comment when I have time. But whatever the final accuracy is about 90%, which is quite impressive.   


[1] [http://www.cl.cam.ac.uk/research/dtg/attarchive/facedatabase.html](http://www.cl.cam.ac.uk/research/dtg/attarchive/facedatabase.html)