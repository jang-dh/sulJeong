package team.hunter.model.dto;

public class Paging {
   /** 한 페이지당 게시글 수 **/
    private int pageSize = 8;
    
    /** 한 블럭(range)당 페이지 수 **/
    private int rangeSize = 10;
    
    /** 현재 페이지 **/
    private int curPage = 1;
    
    /** 현재 블럭(range) **/
    private int curRange = 1;
    
    /** 총 게시글 수 **/
    private int listCnt;
    
    /** 총 페이지 수 **/
    private int pageCnt;
    
    /** 총 블럭(range) 수 **/
    private int rangeCnt;
    
    /** 시작 페이지 **/
    private int startPage = 1;
    
    /** 끝 페이지 **/
    private int endPage = 1;
    
    /** 시작 index **/
    private int startIndex = 1;
    
    /** 이전 페이지 **/
    private int prevPage;
    
    /** 다음 페이지 **/
    private int nextPage;
    
    public Paging(int listCnt, int curPage){
        
        /**
         * 페이징 처리 순서
         * 1. 총 페이지수
         * 2. 총 블럭(range)수
         * 3. range setting
         */
        
        // 총 게시물 수와 현재 페이지를 Controller로 부터 받아온다.
        /** 현재페이지 **/
        setCurPage(curPage);
        /** 총 게시물 수 **/
        setListCnt(listCnt);
        
        /** 1. 총 페이지 수 **/
        setPageCnt(listCnt);
        /** 2. 총 블럭(range)수 **/
        setRangeCnt(pageCnt);
        /** 3. 블럭(range) setting **/
        rangeSetting(curPage);
        
        /** DB 질의를 위한 startIndex 설정 **/
        setStartIndex(curPage);
    }

   public int getPageSize() {
      return pageSize;
   }

   public int getRangeSize() {
      return rangeSize;
   }
   public int getCurPage() {
      return curPage;
   }

   public int getCurRange() {
      return curRange;
   }

   public int getListCnt() {
      return listCnt;
   }

   public int getPageCnt() {
      return pageCnt;
   }

   public int getRangeCnt() {
      return rangeCnt;
   }
   public int getStartPage() {
      return startPage;
   }

   public int getEndPage() {
      return endPage;
   }

   public int getStartIndex() {
      return startIndex;
   }

   public int getPrevPage() {
      return prevPage;
   }

   public int getNextPage() {
      return nextPage;
   }

   public void setCurPage(int curPage) {
      this.curPage = curPage;
   }
    
    public void setListCnt(int listCnt) {
      this.listCnt = listCnt;
   }
 
    public void setPageCnt(int listCnt) {
        this.pageCnt = (int) Math.ceil(listCnt*1.0/pageSize);
    }
    public void setRangeCnt(int pageCnt) {
        this.rangeCnt = (int) Math.ceil(pageCnt*1.0/rangeSize);
    }
    public void rangeSetting(int curPage){
        
        setCurRange(curPage);        
        this.startPage = (curRange - 1) * rangeSize + 1;
        this.endPage = startPage + rangeSize - 1;
        
        if(endPage > pageCnt){
            this.endPage = pageCnt;
        }
        
        this.prevPage = curPage - 1;
        if(this.prevPage<1) this.prevPage=1;
        this.nextPage = curPage + 1;
        if(this.nextPage>endPage) this.nextPage=endPage;
    }
    public void setCurRange(int curPage) {
        this.curRange = (int)((curPage-1)/rangeSize) + 1;
    }
    public void setStartIndex(int curPage) {
        this.startIndex = curPage;
    }
}