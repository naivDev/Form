//
//  ViewController.swift
//  Formulario
//
//  Created by Oscar Ivan Pérez Salazar on 21/01/22.

import UIKit
import CoreData

class ViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Datos a editar segue
    var fLastNameToEdit: String?
    var sLastNameToEdit: String?
    var namesToEdit: String?
    var emailToEdit: String?
    var ageToEdit: String?
    var homNumeToEdit: String?
    var movilNumToEdit: String?
    var directioToEdit: String?
    var colonyToEdit: String?
    var cPToEdit: String?
    var stateToEdit: String?
    var populationToEdit: String?
    var editInfo = "Editar"
    var position: Int?
    
    //Referencia al managed Object Context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Datos Para el tableView
    var infoList = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDelegates()
        setXIBCell()
        fetchPeople()
        
    }
    
    func saveData() {
        do {
            try context.save()
            
        } catch let error as NSError {
            print("Error al Guardar: \(error.localizedDescription)")
        }
    }
    //Refresh CoreData
    override func viewWillAppear(_ animated: Bool) {
        print("______METODO WILLAPPEAR LLAMADO_____")
        self.navigationController?.isNavigationBarHidden = false
        fetchPeople()
        tableView.reloadData()
        
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func setViewXIB() {
        let nibFirstTableViewCell = UINib(nibName: Constants.One, bundle: nil)
        tableView.register(nibFirstTableViewCell, forCellReuseIdentifier: Constants.One)
        let nibSecondTableViewCell = UINib(nibName: Constants.Two, bundle: nil)
        tableView.register(nibSecondTableViewCell, forCellReuseIdentifier: Constants.Two)
    }
    
    func setXIBCell() {
        let nibTableViewCell = UINib(nibName: Constants.Three, bundle: nil)
        tableView.register(nibTableViewCell, forCellReuseIdentifier: Constants.Three)
    }
    
    
    func fetchPeople() {
        do {
            self.infoList =  try context.fetch(Person.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch  {
            
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @IBAction func goToForm(_ sender: UIBarButtonItem) {
        let VC = personalInformationViewController()
        navigationController?.present(VC, animated: true)
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = infoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.IdTVC , for: indexPath) as! TableViewCell
        
        cell.lblName.text = model.name
        cell.lblFirstLastName.text = model.firstLastName
        cell.lblSecondLastName.text = model.secondLastName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        fLastNameToEdit = infoList[indexPath.row].firstLastName
        sLastNameToEdit = infoList[indexPath.row].secondLastName
        namesToEdit = infoList[indexPath.row].name
        ageToEdit = String(infoList[indexPath.row].age)
        emailToEdit = infoList[indexPath.row].email
        homNumeToEdit = String(infoList[indexPath.row].homeNum)
        movilNumToEdit = String(infoList[indexPath.row].movilNum)
        directioToEdit = infoList[indexPath.row].direction
        colonyToEdit = infoList[indexPath.row].colony
        cPToEdit = infoList[indexPath.row].cp
        stateToEdit = infoList[indexPath.row].state
        populationToEdit = infoList[indexPath.row].population
        
        position = indexPath.row
        
        self.performSegue(withIdentifier: "editNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier ==  "editNote") {
            let objectEdit = segue.destination as! personalInformationViewController
            objectEdit.obtainFLastName = fLastNameToEdit
            objectEdit.obtainSLastName = sLastNameToEdit
            objectEdit.obtainName = namesToEdit
            objectEdit.obtainEmail = emailToEdit
            objectEdit.obtainDirection = directioToEdit
            objectEdit.obtainColony = colonyToEdit
            objectEdit.obtainState = stateToEdit
            objectEdit.obtainPopulation = populationToEdit
            objectEdit.obtainCP = cPToEdit
            objectEdit.obtainAge = ageToEdit
            objectEdit.obtainHomNum = homNumeToEdit
            objectEdit.obtainMovilNum = movilNumToEdit
            
            objectEdit.action = editInfo
            
            objectEdit.position = position
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "BORRAR") {( _ , _, _) in
            print("BORRAR ")
            //Eliminar coreData
            self.context.delete(self.infoList[indexPath.row])
            //eliminar de la UI
            self.infoList.remove(at:indexPath.row)
            self.saveData()
            self.tableView.reloadData()
            
        }
        deleteAction.image = UIImage(named: "trashicon.png")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

