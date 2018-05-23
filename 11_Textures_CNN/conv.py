import torch
import torchvision
import torch.nn as nn
import torch.nn.functional as F
from torch.autograd import Variable
from torchvision import datasets, transforms
import numpy as np
import glob
import tqdm
import ipdb
import pdb

#Model
class Net(nn.Module):
    #Layers
    def __init__(self):
        super(Net, self).__init__()

        self.conv1 = nn.Conv2d(3, 64, kernel_size=3) #Channels input: 1, c output: 63
        self.conv2 = nn.Conv2d(64, 512, kernel_size=3)
        self.conv3 = nn.Conv2d(512, 512, kernel_size=3)
        self.fc1 = nn.Linear(512*14*14, 25)
    #Implementation
    def forward(self, x, verbose=False):
        if verbose: "Output Layer by layer"
        if verbose: print(x.size())
	x = F.max_pool2d(F.relu(self.conv1(x)), 2) #Perform a Maximum pooling operation over the nonlinear responses of the convolutional layer
        if verbose: print(x.size())
	x = F.max_pool2d(F.relu(self.conv2(x)),2)
        if verbose: print(x.size())
        x = F.dropout(x, 0.25, training=self.training)#Try to control overfit on the network, by randomly excluding 25% of neurons on the last #layer during each iteration
        if verbose: print(x.size())
	x = F.max_pool2d(F.relu(self.conv3(x)),2)
        if verbose: print(x.size())
        x = F.dropout(x, 0.25, training=self.training)
	#print(x.size())
        if verbose: print(x.size())
        x = x.view(x.size(0), -1)
        if verbose: print(x.size())
	#print(x.size())
        x = self.fc1(x)
	#print(x.size())
        if verbose: print(x.size())
	return F.log_softmax(x, dim=1)

#GPU
model=Net()
model=model.cuda()

#Parameters
num_params=0
for p in model.parameters():
    num_params+=p.numel()
print(model)
print("The number of parameters {}".format(num_params))


#Optimizer
optimizer = torch.optim.SGD(model.parameters(), lr=0.01, momentum=0.9, weight_decay=0.0)
#Loss function
Lossf = nn.NLLLoss()


#Transformations
transform = transforms.Compose([transforms.ToTensor()])

#Get data
   #Train
data_train = datasets.ImageFolder('/home/ramirezrozo/train_128', transform = transform)
train_loader = torch.utils.data.DataLoader(data_train, batch_size=50 ,shuffle=True)
   #Val/tes
data_test = datasets.ImageFolder('/home/ramirezrozo/val_128', transform = transform)
test_loader = torch.utils.data.DataLoader(data_test, batch_size=50, shuffle=False)

#Training
def train(epoch):
    model.train()
    loss_cum = []
    Acc = 0
    for batch_idx, (data,target) in tqdm.tqdm(enumerate(train_loader),total=len(train_loader),desc="[TRAIN] Epoch:{}".format(epoch)):
	#data=data.requires_grad_()
	#data=data.cuda()
        data = data.cuda(); data = Variable(data)
        target = target.cuda(); target = Variable(target)
        output = model(data, verbose=False)
        optimizer.zero_grad()
        loss = Lossf(output,target)
        loss.backward()
	optimizer.step()
        loss_cum.append(loss.data.cpu()[0])
        _, arg_max_out = torch.max(output.data.cpu(), 1)
        Acc += arg_max_out.long().eq(target.data.cpu().long()).sum()

    print("Epoch %d Loss Train: %0.3f | Acc: %0.2f"%(epoch, np.array(loss_cum).mean(), float(Acc*100)/len(train_loader.dataset)))


#Eval
def test(epoch):
    model.eval()
    loss_cum = []
    Acc = 0
#with torch.no_grad()
    for batch_idx, (data,target) in tqdm.tqdm(enumerate(test_loader), total=len(test_loader), desc="[TEST] Epoch: {}".format(epoch)):
        data = data.cuda();
	data = Variable(data, volatile=True)
        target = target.cuda();
	target = Variable(target, volatile=True)

        output = model(data)
        loss = Lossf(output,target)
        loss_cum.append(loss.data.cpu()[0])
        _, arg_max_out = torch.max(output.data.cpu(), 1)
        Acc += arg_max_out.long().eq(target.data.cpu().long()).sum()

    print("Epoch %d Loss Test: %0.3f | Acc Test: %0.2f"%(epoch, np.array(loss_cum).mean(), float(Acc*100)/len(test_loader.dataset)))

if __name__=='__main__':
    epochs=20
    for epoch in range(epochs):
        train(epoch)
        test(epoch)
