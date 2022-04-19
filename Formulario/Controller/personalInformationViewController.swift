//
//  personalInformationViewController.swift
//  Formulario
//
//  Created by Oscar Ivan Pérez Salazar on 21/01/22.
//

import UIKit
import CoreData

class personalInformationViewController: BaseViewController {
    
    //MARK: Referencias IBOutlet
    @IBOutlet weak var fLastNameTxt: UITextField!
    @IBOutlet weak var sLastNameTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var ageTxt: UITextField!
    @IBOutlet weak var homeNumTxt: UITextField!
    @IBOutlet weak var movilNumTxt: UITextField!
    @IBOutlet weak var directionTxt: UITextField!
    @IBOutlet weak var colonyTxt: UITextField!
    @IBOutlet weak var cpTxt: UITextField!
    @IBOutlet weak var stateTxt: UITextField!
    @IBOutlet weak var populationTxt: UITextField!
    
    //MARK: IBOutlet label Validation
    @IBOutlet weak var requiredFirstLastName: UILabel!
    @IBOutlet weak var requiredSecondLastName: UILabel!
    @IBOutlet weak var requiredName: UILabel!
    @IBOutlet weak var requiredEmail: UILabel!
    @IBOutlet weak var requiredAge: UILabel!
    @IBOutlet weak var requiredHomNum: UILabel!
    @IBOutlet weak var requiredMovilNum: UILabel!
    @IBOutlet weak var requiredDirection: UILabel!
    @IBOutlet weak var requiredColony: UILabel!
    @IBOutlet weak var requiredCp: UILabel!
    @IBOutlet weak var requiredState: UILabel!
    @IBOutlet weak var requiredPopulation: UILabel!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    var lastnameFTxt = ""
    var secondLastFTxt = ""
    var nameFTxt = ""
    var ageFTxt = ""
    var emailFTxt = ""
    var homeNumFTxt = ""
    var movilnumFTxt = ""
    var directionFTxt = ""
    var colonyFtxt = ""
    var cpFTxt  = ""
    var stateFTxt = ""
    var populationFTxt = ""
    
    // MARK: Valores obtenidos a editar (SEGUE)
    var obtainName: String?
    var obtainFLastName: String?
    var obtainSLastName: String?
    var obtainEmail:String?
    var obtainAge: String?
    var obtainHomNum: String?
    var obtainMovilNum: String?
    var obtainDirection: String?
    var obtainColony: String?
    var obtainCP: String?
    var obtainState: String?
    var obtainPopulation: String?
    var action: String?
    var position: Int?
    var editTextField: Bool = false
    
    var textFields:[UITextField] = []
    
    
    //Datos Para el tableView
    var infoList = [Person]()
    
    //MARK: Contexto referencia al managed Object Context/Apuntador a la BD CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Arreglo de contactos
    var person: [NSManagedObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editInfo()
        fetcPeople()
        
        if (action != nil) == true {
            disableEditing()
            
            saveButton.isHidden = true
            cancelButton.isHidden = true
            
            
        } else {
            print("ERROR")
            if let button = self.navigationItem.rightBarButtonItem {
                button.isEnabled = false
                button.tintColor = UIColor.clear
            }
            
        }
    }
    // MARK: Dehabilitar textFields
    func disableEditing() {
        fLastNameTxt.isUserInteractionEnabled = false
        sLastNameTxt.isUserInteractionEnabled = false
        nameTxt.isUserInteractionEnabled = false
        ageTxt.isUserInteractionEnabled = false
        emailTxt.isUserInteractionEnabled = false
        homeNumTxt.isUserInteractionEnabled = false
        movilNumTxt.isUserInteractionEnabled = false
        directionTxt.isUserInteractionEnabled = false
        colonyTxt.isUserInteractionEnabled = false
        cpTxt.isUserInteractionEnabled = false
        stateTxt.isUserInteractionEnabled = false
        populationTxt.isUserInteractionEnabled = false
    }
    
    // MARK: Edición de textFields
    @IBAction func editInformationFields(_ sender: Any) {
        
        fLastNameTxt.isUserInteractionEnabled = true
        sLastNameTxt.isUserInteractionEnabled = true
        nameTxt.isUserInteractionEnabled = true
        ageTxt.isUserInteractionEnabled = true
        emailTxt.isUserInteractionEnabled = true
        homeNumTxt.isUserInteractionEnabled = true
        movilNumTxt.isUserInteractionEnabled = true
        directionTxt.isUserInteractionEnabled = true
        colonyTxt.isUserInteractionEnabled = true
        cpTxt.isUserInteractionEnabled = true
        stateTxt.isUserInteractionEnabled = true
        populationTxt.isUserInteractionEnabled = true
        
        saveButton.isHidden = false
        cancelButton.isHidden = false
    }
    
    
    func editInfo() {
        fLastNameTxt.text = obtainFLastName
        sLastNameTxt.text = obtainSLastName
        nameTxt.text = obtainName
        emailTxt.text = obtainEmail
        directionTxt.text = obtainDirection
        colonyTxt.text = obtainColony
        stateTxt.text = obtainState
        populationTxt.text = obtainPopulation
        cpTxt.text = obtainCP
        ageTxt.text = obtainAge
        homeNumTxt.text = obtainHomNum
        movilNumTxt.text = obtainMovilNum
        
    }
    
    func coreDataLoading() {
        //Solicitud de lectura
        let readingRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            person =  try context.fetch(readingRequest) as [NSManagedObject]
        } catch  {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @IBAction func saveInformation(_ sender: Any) {
        validateData()
    }
    
    //MARK: Asignacion de nuevos valores a CoreData
    func changeValues() {
        do {
            infoList[position ?? 0].setValue(nameTxt.text, forKey: "name")
            infoList[position ?? 0].setValue(fLastNameTxt.text, forKey: "firstLastName")
            infoList[position ?? 0].setValue(sLastNameTxt.text, forKey: "secondLastName")
            infoList[position ?? 0].setValue(Int(ageTxt.text!), forKey:"age")
            infoList[position ?? 0].setValue(emailTxt.text, forKey: "email")
            infoList[position ?? 0].setValue(Int(homeNumTxt.text!), forKey: "homeNum")
            infoList[position ?? 0].setValue(Int(movilNumTxt.text!), forKey: "movilNum")
            infoList[position ?? 0].setValue(directionTxt.text, forKey: "direction")
            infoList[position ?? 0].setValue(colonyTxt.text, forKey: "colony")
            infoList[position ?? 0].setValue(cpTxt.text, forKey: "cp")
            infoList[position ?? 0].setValue(stateTxt.text, forKey: "state")
            infoList[position ?? 0].setValue(populationTxt.text, forKey: "population")
            print(infoList)
            
            try self.context.save()
            print("DATO GUARDADO")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Validacion de textFields
    func validateFields() {
        if lastnameFTxt == "" {
            requiredFirstLastName.text = "DATO REQUERIDO"
        } else {
            requiredFirstLastName.text = ""
        }
        if secondLastFTxt == "" {
            requiredSecondLastName.text = "DATO REQUERIDO"
        } else {
            requiredSecondLastName.text = ""
        }
        if nameFTxt == "" {
            requiredName.text = "DATO REQUERIDO"
        } else {
            requiredName.text = ""
        }
        if ageFTxt == "" {
            requiredAge.text = "DATO REQUERIDO"
        } else {
            requiredAge.text = ""
        }
        if emailFTxt == "" {
            requiredEmail.text = "DATO REQUERIDO"
        } else {
            requiredEmail.text = ""
        }
        if homeNumFTxt == "" {
            requiredHomNum.text = "DATO REQUERIDO"
        } else {
            requiredHomNum.text = ""
        }
        if movilnumFTxt == "" {
            requiredMovilNum.text = "DATO REQUERIDO"
        } else {
            requiredMovilNum.text = ""
        }
        if directionFTxt == "" {
            requiredDirection.text = "DATO REQUERIDO"
        } else {
            requiredDirection.text = ""
        }
        if colonyFtxt == "" {
            requiredColony.text = "DATO REQUERIDO"
        } else {
            requiredColony.text = ""
        }
        if cpFTxt == "" {
            requiredCp.text = "DATO REQUERIDO"
        } else {
            requiredCp.text = ""
        }
        if stateFTxt == "" {
            requiredState.text = "DATO REQUERIDO"
        } else {
            requiredState.text = ""
        }
        if populationFTxt == "" {
            requiredPopulation.text = "DATO REQUERIDO"
        } else {
            requiredPopulation.text = ""
        }
        
    }
    //MARK: Nueva variable
    func keepValuesTxtFields() {
        
        lastnameFTxt = fLastNameTxt.text!
        secondLastFTxt = sLastNameTxt.text!
        nameFTxt = nameTxt.text!
        ageFTxt = ageTxt.text!
        emailFTxt = emailTxt.text!
        homeNumFTxt = homeNumTxt.text!
        movilnumFTxt = movilNumTxt.text!
        directionFTxt = directionTxt.text!
        colonyFtxt = colonyTxt.text!
        cpFTxt = cpTxt.text!
        stateFTxt = stateTxt.text!
        populationFTxt = populationTxt.text!
    }
    //MARK: Validación general de datos
    func validateData() {
        
        keepValuesTxtFields()
        validateFields()
        
        if (fLastNameTxt.text != "" && sLastNameTxt.text != "" && nameTxt.text != "" && emailTxt.text != "" && ageTxt.text != "" && homeNumTxt.text != "" &&  movilNumTxt.text != "" && directionTxt.text != "" && colonyTxt.text != "" && cpTxt.text != "" && stateTxt.text != "" && populationTxt.text != "") {
            
            if (action != nil) == true {
                
                changeValues()
                backMainView()
                
            } else {
                
                insertionCoreData()
                backMainView()
                print("CAMPOS LLENADOS")
                
            }
            
        } else {
            let alert = UIAlertController(title: "AVISO", message: "SE REQUIEREN TODOS LOS DATOS PARA GUARDAR INFORMACIÓN ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
    }
    
    func insertionCoreData() {
        //Contexto
        let context = conectionBDCoreData()
        //MARK: Insersion de datos a CoreData
        let queryPerson = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        //Accediendo a las propiedades de la entidades
        queryPerson.firstLastName = lastnameFTxt
        queryPerson.secondLastName = secondLastFTxt
        queryPerson.name = nameFTxt
        queryPerson.email = emailFTxt
        queryPerson.direction = directionFTxt
        queryPerson.colony = colonyFtxt
        queryPerson.cp = cpFTxt
        queryPerson.state = stateFTxt
        queryPerson.population =  populationFTxt
        queryPerson.age = Int64(ageFTxt) ?? 0
        queryPerson.homeNum = Int64(homeNumFTxt) ?? 0
        queryPerson.movilNum = Int64(movilnumFTxt) ?? 0
        
        do {
            try context.save()
            print("INSERSION DE DATOS EN COREDATA ")
        } catch  {
            print("Error al guardar \(error.localizedDescription)")
        }
    }
    
    
    func fetcPeople() {
        do {
            self.infoList =  try context.fetch(Person.fetchRequest())
        } catch  {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func CancelButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Apuntador a la BD de CoreData
    //Apuntador para la la conexion a la BD CoreData
    func conectionBDCoreData() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    //MARK: Lectura de valores agregados a CoreData
    func readDBCoreData() {
        let context = conectionBDCoreData()
        //Solicitud de lectura
        let readingRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            person =  try context.fetch(readingRequest) as [NSManagedObject]
        } catch  {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    //MARK: Recargar datos en CoreData
    func reloadData() {
        DispatchQueue.main.async {
            self.readDBCoreData()
        }
        
    }
    
    func backMainView() {
        navigationController?.popViewController(animated: true)
    }
    
}

