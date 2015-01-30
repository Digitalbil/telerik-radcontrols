using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Telerik.Web.UI;
using Telerik.Web.UI.Gantt;

namespace App_Code
{
    public class GanttProvider : GanttProviderBase
    {
        #region Tasks

        public override List<ITask> GetTasks()
        {
            var tasks = new List<ITask>();

            using (var db = new GanttResourcesEntities())
            {
                tasks.AddRange(db.GanttTasks.ToList().Select(task => new Task
                {
                    ID = task.ID,
                    ParentID = task.ParentID,
                    OrderID = task.OrderID,
                    Start = task.Start,
                    End = task.End,
                    PercentComplete = task.PercentComplete,
                    Summary = task.Summary,
                    Title = task.Title,
                    Expanded = task.Expanded.HasValue && task.Expanded.Value
                }));
            }

            return tasks;
        }

        public override ITask UpdateTask(ITask task)
        {
            using (var db = new GanttResourcesEntities())
            {
                int? pId = null;
                int id = int.Parse(task.ID.ToString());
                var t = db.GanttTasks.First(r => r.ID == id);

                if (task.ParentID != null)
                {
                    pId = int.Parse(task.ParentID.ToString());
                }

                t.ID = id;
                t.ParentID = pId;
                t.OrderID = int.Parse(task.OrderID.ToString());
                t.Start = task.Start;
                t.End = task.End;
                t.PercentComplete = task.PercentComplete;
                t.Summary = task.Summary;
                t.Title = task.Title;
                t.Expanded = task.Expanded;

                db.SaveChanges();
            }

            return task;
        }

        public override ITask DeleteTask(ITask task)
        {
            using (var db = new GanttResourcesEntities())
            {
                int id = int.Parse(task.ID.ToString());
                db.GanttTasks.Remove(db.GanttTasks.First(r => r.ID == id));
                db.SaveChanges();
            }

            return task;
        }

        public override ITask InsertTask(ITask task)
        {
            using (var db = new GanttResourcesEntities())
            {
                int? pId = null;
                int id = string.IsNullOrEmpty(task.ID.ToString()) ? 0 : int.Parse(task.ID.ToString());
                task.ID = null;

                if (task.ParentID != null)
                {
                    pId = int.Parse(task.ParentID.ToString());
                }

                GanttTask result = new GanttTask
                {
                    ID = id,
                    ParentID = pId,
                    OrderID = int.Parse(task.OrderID.ToString()),
                    Start = task.Start,
                    End = task.End,
                    PercentComplete = task.PercentComplete,
                    Summary = task.Summary,
                    Title = task.Title,
                    Expanded = task.Expanded
                };
                db.GanttTasks.Add(result);
                db.SaveChanges();
                task.ID = result.ID;
                task.ParentID = result.ParentID;
                task.OrderID = result.OrderID;
            }

            return task;
        }

        #endregion

        #region Dependencies

        public override List<IDependency> GetDependencies()
        {
            var dependencies = new List<IDependency>();
            using (var db = new GanttResourcesEntities())
            {
                dependencies.AddRange(db.GanttDependencies.ToList().Select(dependency => new Dependency()
                {
                    ID = dependency.ID,
                    PredecessorID = dependency.PredecessorID,
                    SuccessorID = dependency.SuccessorID,
                    Type = (DependencyType)dependency.Type
                }));
            }
            return dependencies;
        }

        public override IDependency UpdateDependency(IDependency dependency)
        {
            return dependency;
        }

        public override IDependency DeleteDependency(IDependency dependency)
        {
            using (var db = new GanttResourcesEntities())
            {
                int id = int.Parse(dependency.ID.ToString());
                db.GanttDependencies.Remove(db.GanttDependencies.First(r => r.ID == id));
                db.SaveChanges();
            }

            return dependency;
        }

        public override IDependency InsertDependency(IDependency dependency)
        {
            using (var db = new GanttResourcesEntities())
            {
                //int id = int.Parse(dependency.ID.ToString());
                //int id = string.IsNullOrEmpty(dependency.ID.ToString()) ? 0 : int.Parse(dependency.ID.ToString());
                int pId = int.Parse(dependency.PredecessorID.ToString());
                int sId = int.Parse(dependency.SuccessorID.ToString());

                var result = new GanttDependency { PredecessorID = pId, SuccessorID = sId, Type = (int)dependency.Type };
                db.GanttDependencies.Add(result);

                db.SaveChanges();

                dependency.ID = result.ID;
                dependency.PredecessorID = result.ID;
                dependency.SuccessorID = result.SuccessorID;
            }

            return dependency;
        }

        #endregion 

        #region Resources
        public override List<IResource> GetResources()
        {
            var resources = new List<IResource>();
            using (var db = new GanttResourcesEntities())
            {
                resources.AddRange(db.GanttResources.ToList().Select(resource => new Telerik.Web.UI.Gantt.Resource()
                {    
                    ID = resource.ID,
                    Text = resource.Name,
                    Color = System.Drawing.ColorTranslator.FromHtml(resource.Color)
                }));
            }
            return resources;
        }
        #endregion 

        #region Assignments
        public override List<IAssignment> GetAssignments()
        {
            var assignments = new List<IAssignment>();
            using (var db = new GanttResourcesEntities())
            {
                assignments.AddRange(db.GanttResourceAssignments.ToList().Select(assignment => new Assignment()
                {
                    ID = assignment.ID,
                    ResourceID = assignment.ResourceID,
                    TaskID = assignment.TaskID,
                    Units = assignment.Units
                }));
            }
            return assignments;
        }

        public override IAssignment UpdateAssignment(IAssignment assignment)
        {
            int id = int.Parse(assignment.ID.ToString()),
                rId = int.Parse(assignment.ResourceID.ToString()),
                tId = int.Parse(assignment.TaskID.ToString());

            decimal units = decimal.Parse(assignment.Units.ToString());

            using (var db = new GanttResourcesEntities())
            {
                var dbAssignment = db.GanttResourceAssignments.Where(x => x.ID == id).FirstOrDefault();
                dbAssignment.ResourceID = rId;
                dbAssignment.TaskID = tId;
                dbAssignment.Units = units;

                db.SaveChanges();
            }
            return assignment;
        }

        public override IAssignment InsertAssignment(IAssignment assignment)
        {
            using (var db = new GanttResourcesEntities())
            {
                int rId = int.Parse(assignment.ResourceID.ToString());
                int tId = int.Parse(assignment.TaskID.ToString());
                decimal units = decimal.Parse(assignment.Units.ToString());
                
                var result = new GanttResourceAssignment { ResourceID = rId, TaskID = tId, Units = units };
                db.GanttResourceAssignments.Add(result);
                db.SaveChanges();

                assignment.ID = result.ID;
                assignment.ResourceID = result.ResourceID;
                assignment.TaskID = result.TaskID;
            }
            return assignment;
        }

        public override IAssignment DeleteAssignment(IAssignment assignment)
        {
            using (var db = new GanttResourcesEntities())
            {
                int id = int.Parse(assignment.ID.ToString());
                db.GanttResourceAssignments.Remove(db.GanttResourceAssignments.First(r => r.ID == id));
                db.SaveChanges();
            }

            return assignment;
        }
        #endregion
    }
}