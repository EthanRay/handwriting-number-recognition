<div>
	<p>
		<a name="OLE_LINK5"></a><a name="OLE_LINK4"></a><a name="OLE_LINK3"></a><a name="OLE_LINK2"><span style="font-size:14px;">雷禧生</span></a><span style="font-size:14px;">模式识别课程作业</span>
	</p>
	<p>
		<span style="font-size:14px;">基于知识库的手写体数字识别</span>
	</p>
	<p>
		<span style="font-size:14px;">案例背景：</span>
	</p>
	<p>
		<span style="font-size:14px;">手写体数字识别是图像识别学科下的一个分支，是图像处理和模式识别研究领域的重要应用之一，并且具有很强的通用性。由于手写数字的随意性很大，如笔画粗细、字体大小、倾斜角度等因素都有可能直接影响到字符的识别准确率，所以手写体数字识别是一个很有挑战性的课题。在过去的数十年中，研究者们提出了许多识别方法，并取得了一定的成果。在大规模数据统计如例行年检、人口普查、财务、税务、邮件分拣等应用领域都有广阔的应用前景。</span>
	</p>
	<p>
		<span style="font-size:14px;">本案例实现了手写阿拉伯数字的识别过程，并对手写数字识别的基于统计的方法进行了简要介绍和分析。本文实现的手写字体识别程序具有手写数字图像读取、特征提取、数字模板特征库以及识别功能。</span>
	</p>
	<p>
		<span style="font-size:14px;">理论基础：</span>
	</p>
	<p>
		<span style="font-size:14px;">算法流程</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-size:14px;">首先，读入手写数字图片进行归一化处理，统一尺寸。默认为</span><span style="font-family:Calibri;font-size:14px;">24</span><span style="font-size:14px;">×</span><span style="font-family:Calibri;font-size:14px;">24</span><span style="font-size:14px;">图形块，并通过</span><span style="font-family:Calibri;font-size:14px;">ostu</span><span style="font-size:14px;">算法进行二值化；其次，对二值化图像进行图像细化等形态学操作，并按照算法要求进行特征提取；最后，载入模板矩阵进行对比，选用欧式距离测度，得到识别结果。其算法流程如图</span><span style="font-family:Calibri;font-size:14px;">1</span><span style="font-size:14px;">所示。</span>
	</p>
	<p>
		<span style="font-size:14px;">特征提取</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-size:14px;">根据手写数字图像本身的结构特征，通过计算端点、指定方向直线的交叉点个数来作为特征向量。其主要步骤如下：</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 . </span><span style="font-size:14px;">垂直交点。</span><a name="OLE_LINK1"><span style="font-size:14px;">对细化后的手写数字图像分别在其列宽的</span></a><span style="font-family:Calibri;font-size:14px;">5/12</span><span style="font-size:14px;">、</span><span style="font-family:Calibri;font-size:14px;">1/2</span><span style="font-size:14px;">、</span><span style="font-family:Calibri;font-size:14px;">7/12</span><span style="font-size:14px;">处生成垂直的三条直线，提取这三条垂直直线与数字笔画的角点数并存储。</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 . </span><span style="font-size:14px;">水平交点。对细化后的手写数字图像分别在其列宽的</span><span style="font-family:Calibri;font-size:14px;">1/3</span><span style="font-size:14px;">、</span><span style="font-family:Calibri;font-size:14px;">1/2</span><span style="font-size:14px;">、</span><span style="font-family:Calibri;font-size:14px;">2/3</span><span style="font-size:14px;">处生成水平的三条直线，提取这三条垂直直线与数字笔画的角点数并存储。</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 . </span><span style="font-size:14px;">对角交点。对细化后的手写数字图像分别提取两条对角直线，提取这两条对角直线与数字笔画的交点数并存储。</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-size:14px;">由于以上步骤均作用于细化后的数字图像，其笔画简单且特征稳定，因此对其提取的基本交点及结构端点能反映数字的本质特征，可快速、有效地识别数字字符，并达到较好的识别正确率。其中，提取笔画结构端点特征的算法如下。</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 . </span><span style="font-size:14px;">目标定位。对细化后的手写数字图像按行从上到下、按列从左到右进行顺序扫描，定位选择黑像素点</span><span style="font-family:Calibri;font-size:14px;">P</span><span style="font-size:14px;">作为手写笔画目标。</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 . </span><span style="font-size:14px;">邻域统计。计算黑色像素</span><span style="font-family:Calibri;font-size:14px;">P</span><span style="font-size:14px;">的</span><span style="font-family:Calibri;font-size:14px;">8</span><span style="font-size:14px;">领域之和</span><span style="font-family:Calibri;font-size:14px;">N</span><span style="font-size:14px;">，若</span><span style="font-family:Calibri;font-size:14px;">N=1</span><span style="font-size:14px;">，则像素</span><span style="font-family:Calibri;font-size:14px;">P</span><span style="font-size:14px;">为端点，端点计数器加</span><span style="font-family:Calibri;font-size:14px;">1</span><span style="font-size:14px;">；否则舍弃该点。</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 . </span><span style="font-size:14px;">遍历图像。遍历整个图像，重复进行目标定位、领域统计的操作流程，提取端点特征。依据上述对手写数字图像的交点、端点特征提取方法，本案例中的特征向量</span><span style="font-family:Calibri;font-size:14px;">VEC</span><span style="font-size:14px;">由</span><span style="font-family:Calibri;font-size:14px;">9</span><span style="font-size:14px;">个分类组成，其排列如下：</span><span style="font-family:Calibri;font-size:14px;">VEC=[</span><span style="font-size:14px;">垂直</span><span style="font-family:Calibri;font-size:14px;">5/12</span><span style="font-size:14px;">处交点数，垂直中线交点数，垂直</span><span style="font-family:Calibri;font-size:14px;">7/12</span><span style="font-size:14px;">处交点数，</span>
	</p>
	<p>
		<span style="font-size:14px;">水平</span><span style="font-family:Calibri;font-size:14px;">1/3</span><span style="font-size:14px;">处交点数，水平中线交点数，水平</span><span style="font-family:Calibri;font-size:14px;">2/3</span><span style="font-size:14px;">处交点数，左对角线交点数，右对角线交点数，端点数</span><span style="font-family:Calibri;font-size:14px;">]</span>
	</p>
	<p>
		<span style="font-size:14px;">模式识别</span>
	</p>
	<p>
		<span style="font-size:14px;">本案例采用的是基于模式知识库的识别方法，所以系统调研的关键步骤就是对数字字符的结构特征的分析及其模型的构造。因此，本案例首先对</span><span style="font-family:Calibri;font-size:14px;">0-9</span><span style="font-size:14px;">这</span><span style="font-family:Calibri;font-size:14px;">10</span><span style="font-size:14px;">个数字进行结构分析并建模，然后提取相关特征，最后构造模板库。</span>
	</p>
	<p>
		<span style="font-size:14px;">在实验过程中，我们选择规范手写和自由手写两组样本对知识库进行参数调整，这些训练样本由</span><span style="font-family:Calibri;font-size:14px;">200</span><span style="font-size:14px;">个规范手写样本和</span><span style="font-family:Calibri;font-size:14px;">200</span><span style="font-size:14px;">个自由手写样本组成，通过计算样本对应分量的算术平均值获得知识库中特征向量的每个分量。</span>
	</p>
	<p>
		<span style="font-size:14px;">通过上述步骤得到的知识库由两套模板组成，在本次实验过程中，我们选择基于模板匹配的识别方法，通过技术欧式距离来衡量匹配程度。识别系统中的特征向量包含</span><span style="font-family:Calibri;font-size:14px;">9</span><span style="font-size:14px;">个分量，且计算距离公式是欧式距离。因此，在识别过程中分别计算待识别图像与知识库中各个模板特征向量之间的欧式距离，即与</span><span style="font-family:Calibri;font-size:14px;">0-9</span><span style="font-size:14px;">这</span><span style="font-family:Calibri;font-size:14px;">10</span><span style="font-size:14px;">个数字逐个比较，选择最小距离对应的数字作为最后的识别结果。</span>
	</p>
	<p>
		<span style="font-size:14px;">不足与展望</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-size:14px;">手写体数字的样本类别只有</span><span style="font-family:Calibri;font-size:14px;">10</span><span style="font-size:14px;">类，与其他大字符集的识别相比要容易得多。本案例采用的模板匹配分类器节省时间，简单却也可以达到较高的识别效果。但是在系统的设计上由于实验条件限制，只采用了</span><span style="font-family:Calibri;font-size:14px;">200</span><span style="font-size:14px;">组样本图像进行特征提取，得到模板库。特征训练不够导致识别率不高，可以考虑增加训练样本，采用神经网络等识别器进行处理，提高识别率。</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;</span>
	</p>
	<p>
		<span style="font-family:Calibri;font-size:14px;">&nbsp;</span>
	</p>
</div>
