# Tool: DeepTRE (Tensor-based Robustness Evaluation of DNNs for the Hamming Distance)

__Wenjie Ruan, Min Wu, Youcheng Sun, Xiaowei Huang, Daniel Kroening, Marta Kwiatkowska.__

Global Robustness Evaluation of Deep Neural Networks with Provable Guarantees for the Hamming Distance

The paper is accepted by the 28th International Joint Conference on Artificial Intelligence (IJCAI-19).
https://doi.org/10.24963/ijcai.2019/824

Email: wenjie.ruan@cs.ox.ac.uk

# Abstract
Deployment of deep neural networks (DNNs) in safety or security-critical systems demands provable guarantees on their correct behaviour. One example is the robustness of image classification decisions, defined as the invariance of the classification for a given input over a small neighbourhood of images around the input. Here we focus on the L_0 norm, and study the problem of quantifying the global robustness of a trained DNN, where global robustness is defined as the expectation of the maximum safe radius over a testing dataset. We first show that the problem is NP-hard, and then propose an approach to iteratively generate lower and upper bounds on the network's robustness. The approach is anytime, i.e., it returns intermediate bounds and robustness estimates that are gradually, but strictly, improved as the computation proceeds; tensor-based, i.e., the computation is conducted over a set of inputs simultaneously, instead of one by one, to enable efficient GPU computation; and has provable guarantees, i.e., both the bounds and the robustness estimates can converge to their optimal values. Finally, we demonstrate the utility of the proposed approach in practice to compute tight bounds by applying and adapting the anytime algorithm to a set of challenging problems, including global robustness evaluation, guidance for the design of robust DNNs, competitive L0 attacks, generation of saliency maps for model interpretability, and test generation for DNNs. We release the code of all case studies via Github.


# Sample Results

![alt text](Documents/Capture1.PNG)

![alt text](Documents/Capture4.PNG)

![alt text](Documents/Capture6.PNG)

![alt text](Documents/Capture7.PNG)

# Run
Please run this tool by referring to different case-study folders

# Citation
```
@inproceedings{ruan2019global,
  title     = {Global Robustness Evaluation of Deep Neural Networks with Provable Guarantees for the Hamming Distance},
  author    = {Ruan, Wenjie and Wu, Min and Sun, Youcheng and Huang, Xiaowei and Kroening, Daniel and Kwiatkowska, Marta},
  booktitle = {Proceedings of the Twenty-Eighth International Joint Conference on Artificial Intelligence, {IJCAI-19}},
  publisher = {International Joint Conferences on Artificial Intelligence Organization},            
  pages     = {5944--5952},
  year      = {2019},
  month     = {7},
  doi       = {10.24963/ijcai.2019/824},
  url       = {https://doi.org/10.24963/ijcai.2019/824},
}

```

# Remark
This tool is under active development and maintenance, please feel free to contact us about any problem encountered. 

## Contribution List of the Case Studies:

Case Study One: Convergence Analysis and Global Robustness Evaluation (Wenjie Ruan, wenjie.ruan@cs.ox.ac.uk)

Case Study Two: Guidance for the Design of Robust DNN Architecture (Wenjie Ruan, wenjie.ruan@cs.ox.ac.uk)

Case Study Three: Competitive L0 Attack (Min Wu, min.wu@cs.ox.ac.uk)

Case Study Four: Saliency Map and Local Robustness Evaluation for Large-scale ImageNet DNN Models (Wenjie Ruan, wenjie.ruan@cs.ox.ac.uk)

Case Study Five: DNNs Test Case Generation (Youcheng Sun, youcheng.sun@cs.ox.ac.uk)
 
