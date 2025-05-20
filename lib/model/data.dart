Map<String, List<String>> pinyinMap = {
  'A': ['a', 'ai', 'an', 'ang', 'ao'],
  'B': ['ba', 'bo', 'bai', 'bei', 'bao', 'ban', 'ben', 'bang', 'beng', 'bi', 'bie', 'biao', 'bian', 'bin', 'bing'],
  'P': ['pa', 'po', 'pai', 'pao', 'pou', 'pan', 'pen', 'pang', 'peng', 'pi', 'pie', 'piao', 'pian', 'pin', 'ping'],
  'M': ['ma', 'mo', 'me', 'mai', 'mao', 'mou', 'man', 'men', 'mang', 'meng', 'mi', 'mie', 'miao', 'miu', 'mian', 'min', 'ming'],
  'F': ['fa', 'fo', 'fei', 'fou', 'fan', 'fen', 'fang', 'feng'],
  'D': ['da', 'de', 'dai', 'dei', 'dao', 'dou', 'dan', 'dang', 'deng', 'di', 'die', 'diao', 'diu', 'dian', 'ding'],
  'T': ['ta', 'te', 'tai', 'tao', 'tou', 'tan', 'tang', 'teng', 'ti', 'tie', 'tiao', 'tian', 'ting'],
  'N': ['na', 'nai', 'nei', 'nao', 'no', 'nen', 'nang', 'neng', 'ni', 'nie', 'niao', 'niu', 'nian', 'nin', 'niang', 'ning'],
  'L': ['la', 'le', 'lai', 'lei', 'lao', 'lou', 'lan', 'lang', 'leng', 'li', 'lia', 'lie', 'liao', 'liu', 'lian', 'lin', 'liang', 'ling'],
  'G': ['ga', 'ge', 'gai', 'gei', 'gao', 'gou', 'gan', 'gen', 'gang', 'geng'],
  'K': ['ka', 'ke', 'kai', 'kou', 'kan', 'ken', 'kang', 'keng'],
  'H': ['ha', 'he', 'hai', 'hei', 'hao', 'hou', 'hen', 'hang', 'heng'],
  'J': ['ji', 'jia', 'jie', 'jiao', 'jiu', 'jian', 'jin', 'jiang', 'jing'],
  'Q': ['qi', 'qia', 'qie', 'qiao', 'qiu', 'qian', 'qin', 'qiang', 'qing'],
  'X': ['xi', 'xia', 'xie', 'xiao', 'xiu', 'xian', 'xin', 'xiang', 'xing'],
  'ZH': ['zha', 'zhe', 'zhi', 'zhai', 'zhao', 'zhou', 'zhan', 'zhen', 'zhang', 'zheng'],
  'CH': ['cha', 'che', 'chi', 'chai', 'chou', 'chan', 'chen', 'chang', 'cheng'],
  'SH': ['sha', 'she', 'shi', 'shai', 'shao', 'shou', 'shan', 'shen', 'shang', 'sheng'],
  'R': ['re', 'ri', 'rao', 'rou', 'ran', 'ren', 'rang', 'reng'],
  'Z': ['za', 'ze', 'zi', 'zai', 'zao', 'zou', 'zang', 'zeng'],
  'C': ['ca', 'ce', 'ci', 'cai', 'cao', 'cou', 'can', 'cen', 'cang', 'ceng'],
  'S': ['sa', 'se', 'si', 'sai', 'sao', 'sou', 'san', 'sen', 'sang', 'seng'],
  'Y': ['ya', 'yao', 'you', 'yan', 'yang', 'yu', 'ye', 'yue', 'yuan', 'yi', 'yin', 'yun', 'ying'],
  'W': ['wa', 'wo', 'wai', 'wei', 'wan', 'wen', 'wang', 'weng', 'wu'],
};

const List<String> shengMuList = [
  'b',
  'p',
  'm',
  'f',
  'd',
  't',
  'n',
  'l',
  'g',
  'k',
  'h',
  'j',
  'q',
  'x',
  'zh',
  'ch',
  'sh',
  'r',
  'z',
  'c',
  's',
  'y',
  'w',
];

const List<String> danYunmuList = [
  'a',
  'o',
  'e',
  'i',
  'u',
  'ü',
];

const List<String> fuYunmuList = [
  'ai',
  'ei',
  'ui',
  'ao',
  'ou',
  'iu',
  'ie',
  'üe',
  'er', // "er" 有时被视为特殊韵母，但按您提供的列表加入
];

const List<String> qianBiYunmuList = [
  'an',
  'en',
  'in',
  'un',
  'ün',
];

List<String> houBiYunmuList = [
  'ang',
  'eng',
  'ing',
  'ong',
];

List<String> zhengtiRenduYinjieList = [
  'zhi',
  'chi',
  'shi',
  'ri',
  'zi',
  'ci',
  'si',
  'yi',
  'wu',
  'yu',
  'ye',
  'yue',
  'yuan',
  'yin',
  'yun',
  'ying',
];
