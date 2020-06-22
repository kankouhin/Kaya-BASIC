class wxPrintoutEx: public wxPrintout
{
public:
    wxPrintoutEx(int maxPage)
        : _maxPage(maxPage) { }

    virtual bool OnPrintPage(int page) wxOVERRIDE;
    virtual bool HasPage(int page) wxOVERRIDE;
    virtual bool OnBeginDocument(int startPage, int endPage) wxOVERRIDE;
    virtual void GetPageInfo(int *minPage, int *maxPage, int *selPageFrom, int *selPageTo) wxOVERRIDE;
    
private:
	int _maxPage;
};

bool wxPrintoutEx::OnPrintPage(int page)
{
    wxDC *dc = GetDC();
    if (dc)
    {
     	PrintPage(dc, page);
        return true;
    }
    else
        return false;
}

bool wxPrintoutEx::OnBeginDocument(int startPage, int endPage)
{
    if (!wxPrintout::OnBeginDocument(startPage, endPage))
        return false;

    return true;
}

void wxPrintoutEx::GetPageInfo(int *minPage, int *maxPage, int *selPageFrom, int *selPageTo)
{
    *minPage = 1;
    *maxPage = _maxPage;
    *selPageFrom = 1;
    *selPageTo = _maxPage;
}

bool wxPrintoutEx::HasPage(int pageNum)
{
    return (pageNum >= 1 && pageNum <= _maxPage);
}
