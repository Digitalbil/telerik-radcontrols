using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DownloadProgressArea_SignalR.App_Code
{
    public class ProgressData
    {
        public int PrimaryPercent  { get; set; }
        public string PrimaryTotal { get; set; }
        public string PrimaryValue { get; set; }
        public int SecondaryPercent { get; set; }
        public string SecondaryTotal { get; set; }
        public string SecondaryValue { get; set; }
        public string CurrentOperationText { get; set; }
        public string TimeElapsed { get; set; }
        public string TimeEstimated { get; set; }
        public string TransferSpeed { get; set; }
        public bool Completed { get; set; }
    }
}