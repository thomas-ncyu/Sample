using Sample.Domain;
using System.Collections.Generic;

namespace Sample.Repository.Interface
{
    public interface IEmployeeRepository
    {
        Employee GetOne(int id);

        IEnumerable<Employee> GetEmployees();
    }
}